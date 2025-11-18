# GitHub Push Instructions

## Authentication Required

To push to `https://github.com/ranadheernakka/Urban-App-UI-Flutter.git`, you need to authenticate with the correct GitHub account.

## Option 1: Using Personal Access Token (Recommended)

1. **Generate a Personal Access Token:**
   - Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Click "Generate new token (classic)"
   - Give it a name (e.g., "Urban-App-Push")
   - Select scopes: `repo` (full control of private repositories)
   - Click "Generate token"
   - **Copy the token** (you won't see it again!)

2. **Push using the token:**
   ```bash
   git push https://YOUR_TOKEN@github.com/ranadheernakka/Urban-App-UI-Flutter.git main
   ```
   Replace `YOUR_TOKEN` with your actual token.

## Option 2: Using GitHub CLI

1. **Install GitHub CLI** (if not installed):
   ```bash
   # Windows (using winget or download from github.com/cli/cli)
   winget install GitHub.cli
   ```

2. **Authenticate:**
   ```bash
   gh auth login
   ```

3. **Push:**
   ```bash
   git push -u origin main
   ```

## Option 3: Update Git Credentials

1. **Clear cached credentials:**
   ```bash
   git credential-manager-core erase
   ```
   Or on Windows:
   ```bash
   cmdkey /list
   # Find and delete GitHub credentials
   ```

2. **Push again** - Windows will prompt for credentials:
   ```bash
   git push -u origin main
   ```
   Use your GitHub username and Personal Access Token as password.

## Option 4: Add as Collaborator

If you don't have access to the repository, ask the repository owner (`ranadheernakka`) to:
1. Go to the repository settings
2. Navigate to "Collaborators"
3. Add your GitHub username as a collaborator

## Quick Command Reference

```bash
# Check current remote
git remote -v

# Update remote URL
git remote set-url origin https://github.com/ranadheernakka/Urban-App-UI-Flutter.git

# Push with authentication
git push -u origin main
```

## Troubleshooting

- **403 Forbidden**: You don't have write access. Use a token or get added as collaborator.
- **Authentication failed**: Clear credentials and try again with a token.
- **Repository not found**: Make sure the repository exists and you have access.

