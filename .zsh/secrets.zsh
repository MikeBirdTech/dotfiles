# Secrets
# Using Bitwarden Secret Manager CLI 
# Usage: bws [option] <command>

# File to store the encrypted BWS access token
BWS_TOKEN_FILE="$HOME/.bws_token.enc"
BWS_CACHE_FILE="$HOME/.bws_cache"

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

# Function to cache API keys
update_api_key_cache() {
    bws_ensure_token || return 1
    local project_name="apikey"
    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')
    
    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found." >&2
        return 1
    fi

    bws secret list "$project_id" | jq -c '.[]' > "$BWS_CACHE_FILE"
    echo "API keys cached successfully."
}
alias update_bws_cache='update_api_key_cache'

# Function to load API keys from cache
load_api_keys_from_cache() {
    if [ ! -f "$BWS_CACHE_FILE" ]; then
        echo "Cache file not found. Run 'update_cache' to create it." >&2
        return 1
    fi

    while IFS= read -r secret; do
        key=$(echo "$secret" | jq -r '.key')
        value=$(echo "$secret" | jq -r '.value')
        export "$key"="$value"
    done < "$BWS_CACHE_FILE"
}

# Stores an API key as a new secret
# Usage: newapikey <KEY> <VALUE>
store_api_key() {
    bws_ensure_token || { echo "Unable to create secret. BWS access token is not set. Use bws_set_token to set it."; return 1; }

    local key="$1"
    local value="$2"
    local project_name="apikey"

    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')

    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found. Please create this project in Bitwarden Secrets Manager." >&2
        return 1
    fi

    bws secret create "$key" "$value" "$project_id"
    if [ $? -eq 0 ]; then
        echo "Secret '$key' created successfully"
        # Update the cache immediately after creating a new secret
        update_api_key_cache
    else
        echo "Failed to create secret '$key'"
    fi
}
alias newapikey='store_api_key'

# Load cached API keys when starting a new shell session
if [ -f "$BWS_CACHE_FILE" ]; then
    load_api_keys_from_cache
else
    echo "Cache file not found. Run 'update_cache' to create it."
    echo "For setup instructions, run 'bws_help'."

fi

# Function to display setup instructions
bws_help() {
    echo "Bitwarden Secret Manager Setup and Usage:"
    echo "1. Run 'bws_set_token' to securely store your BWS access token."
    echo "2. Run 'update_cache' to create or refresh the cache of your API keys."
    echo "3. Use 'newapikey <KEY> <VALUE>' to add new API keys."
    echo "4. Run 'update_cache' manually if you need to refresh the cache."
    echo "5. Use 'bws_help' to display these instructions again."
}
alias bws_help='bws_help'
