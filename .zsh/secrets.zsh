# Secrets
# Using Bitwarden Secret Manager CLI 
# Usage: bws [option] <command>

# File to store the encrypted BWS access token
BWS_TOKEN_FILE="$HOME/.bws_token.enc"

# Function to securely set the BWS access token
bws_set_token() {
    echo -n "Enter your BWS access token: "
    read -s token
    echo  # New line after hidden input
    echo -n "$token" | openssl pkeyutl -encrypt -pubin -inkey ~/.ssh/bws_token_key.pub.pem -out "$BWS_TOKEN_FILE"
    if [ $? -eq 0 ]; then
        echo "BWS token encrypted and stored securely."
    else
        echo "Failed to encrypt the BWS token. Please try again."
        rm -f "$BWS_TOKEN_FILE"  # Remove the file if encryption failed
    fi
}

# Function to retrieve the BWS access token securely
bws_get_token() {
    if [ ! -f "$BWS_TOKEN_FILE" ]; then
        echo "BWS token not found. Please set it using bws_set_token" >&2
        return 1
    fi
    if [ ! -f ~/.ssh/bws_token_key ]; then
        echo "Private key not found at ~/.ssh/bws_token_key" >&2
        return 1
    fi
    openssl pkeyutl -decrypt -inkey ~/.ssh/bws_token_key -in "$BWS_TOKEN_FILE"
}

# Function to ensure BWS access token is set
bws_ensure_token() {
    if [ -z "$BWS_ACCESS_TOKEN" ]; then
        export BWS_ACCESS_TOKEN=$(bws_get_token)
        if [ $? -ne 0 ]; then
            echo "Failed to retrieve BWS access token. Please set it using bws_set_token" >&2
            return 1
        fi
    fi
}

# Stores an API key as a new secret
# Usage: store_api_key <KEY> <VALUE>
store_api_key() {
    bws_ensure_token || { echo "Unable to create secret. BWS access token is not set. Use bws_set_token to set it."; return 1; }

    local key="$1"
    local value="$2"
    local project_name="apikey"

    # Get the project ID
    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')

    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found. Please create this project in Bitwarden Secrets Manager." >&2
        return 1
    fi

    # Create the secret
    bws secret create "$key" "$value" "$project_id"
    echo "Secret '$key' created successfully"

    # Reload secret into environment variables
    load_api_keys
}
alias newapikey='store_api_key'

# Loads API keys into environment variables
load_api_keys() {
    bws_ensure_token || { echo "Unable to load secrets. BWS access token is not set. Use bws_set_token to set it."; return 1; }

    local project_name="apikey"
    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')

    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found. Please create this project in Bitwarden Secrets Manager." >&2
        return 1
    fi

    while IFS= read -r secret; do
        key=$(echo "$secret" | jq -r '.key')
        value=$(echo "$secret" | jq -r '.value')
        export "$key"="$value"
    done < <(bws secret list "$project_id" | jq -c '.[]')

    echo "All secrets from project '$project_name' have been loaded as environment variables."
}

# Ensure BWS token is set and load secrets when starting a new shell session
bws_ensure_token && load_api_keys|| echo "Failed to load API keys. Please check your bws setup and token."
