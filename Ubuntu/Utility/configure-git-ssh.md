## How to configure git ssh
### Generate ssh key pair
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"  # Start SSH agent to add key
ssh-add ~/.ssh/id_ed25519
```
private key: `~/.ssh/id_ed25519`
public key: `~/.ssh/id_ed25519.pub`

### Add to ~/.ssh/config

```text
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_ed25519
```

### Add public key in github
### Verify git-ssh access
```shell
ssh -T git@github.com
```
### Update repository's remote url to new ssh-git url

## How to configure git gpg [Optional]
### Generate GPG key
```shell
sudo apt install gnupg
gpg --full-generate-key
```

1. Select the default options (RSA and RSA, 3072 bits, no expiration).
2. Enter your name and email address (use the same email as your GitHub account).
3. Set a passphrase for your key.

### Add gpg key in github
```shell
gpg --armor --export <Your GPG ID>
```
You take `<Your GPG ID>` from the result of previous command. For example, `A9B55591F0FC5C2B`.

### Configure git local of the repository

```shell
git config --local user.signingkey A9B55591F0FC5C2B
git config --local commit.gpgsign true
```
