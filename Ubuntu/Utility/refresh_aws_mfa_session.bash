#! /bin/bash
# Usage: source refresh_aws_mfa_session.bash <OTP-CODE> [force]

if [ "${BASH_SOURCE[0]}" -ef "$0" ]
then
    echo "The script must be sourced within the shell, do not execute it."
    exit 1
fi

MfaDeviceArn='arn:aws:iam::298080379523:mfa/FanPhone'
DurationInSeconds=129600
OTP="$1"
FORCE="$2"

if [ -z "$OTP" ]; then
    echo "Missing OTP-CODE."
    return 1
fi

if [ "$FORCE" != "force" ]; then
    FORCE=""
fi

if [ -z "$FORCE" ]; then
    if aws s3 ls >/dev/null 2>&1; then
        echo "Do nothing. The current session is still alive."
        echo 'If you persist, please rerun the command with "force" at the end.'
        return 0
    else
        eval "$(grep -E '^\s*export\s*AWS_ACCESS_KEY_ID=.*$' ~/.bashrc)"
        eval "$(grep -E '^\s*export\s*AWS_SECRET_ACCESS_KEY=.*$' ~/.bashrc)"
        eval "$(grep -E '^\s*export\s*AWS_SESSION_TOKEN=.*$' ~/.bashrc)"
        if aws s3 ls >/dev/null 2>&1; then
            echo "Load cached token => Access Granted"
            return 0
        fi
    fi
fi

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

JSON=$(aws sts get-session-token --serial-number "$MfaDeviceArn" --token-code "$OTP" --duration-seconds "$DurationInSeconds" --profile default)
AWS_ACCESS_KEY_ID=$(echo "$JSON" | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo "$JSON" | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo "$JSON" | jq -r '.Credentials.SessionToken')
if [ -z "$JSON" ] || [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_SESSION_TOKEN" ]; then
    echo "Failed to get session token."
    return 1
fi

EXP_TIME=$(echo "$JSON" | jq -r '.Credentials.Expiration')
echo "Token Expire Time: $EXP_TIME"

sed -i '/^\s*export AWS_ACCESS_KEY_ID=/d' ~/.bashrc
sed -i '/^\s*export AWS_SECRET_ACCESS_KEY=/d' ~/.bashrc
sed -i '/^\s*export AWS_SESSION_TOKEN=/d' ~/.bashrc

echo "export AWS_ACCESS_KEY_ID=\"$AWS_ACCESS_KEY_ID\"" >> ~/.bashrc
echo "export AWS_SECRET_ACCESS_KEY=\"$AWS_SECRET_ACCESS_KEY\"" >> ~/.bashrc
echo "export AWS_SESSION_TOKEN=\"$AWS_SESSION_TOKEN\"" >> ~/.bashrc 

export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"

echo "Done."
