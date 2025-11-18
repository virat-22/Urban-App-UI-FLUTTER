# Push Instructions for GitHub

## Quick Push Guide

Your project is ready to push! You have **2 commits** ready:
1. Initial commit: Flutter mobile app with Node.js backend API
2. Update: Add LICENSE, improve README, add CONTRIBUTING guide, fix imports

## Method 1: Personal Access Token (Easiest)

### Step 1: Create Token
1. Go to: **https://github.com/settings/tokens**
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Name: `Urban-App-Push`
4. Expiration: Choose duration (30 days, 60 days, etc.)
5. **Check the `repo` scope** (Full control of private repositories)
6. Click **"Generate token"**
7. **COPY THE TOKEN** (you won't see it again!)

### Step 2: Push with Token
Open PowerShell or Command Prompt in this directory and run:

```bash
git push https://YOUR_TOKEN@github.com/ranadheernakka/Urban-App-UI-Flutter-.git main
```

Replace `YOUR_TOKEN` with the token you copied.

**Example:**
```bash
git push https://ghp_xxxxxxxxxxxxxxxxxxxx@github.com/ranadheernakka/Urban-App-UI-Flutter-.git main
```

## Method 2: GitHub CLI

If you have GitHub CLI installed:

```bash
gh auth login
# Follow the prompts:
# - Choose GitHub.com
# - Choose HTTPS
# - Authenticate in browser
# - Choose your account

git push origin main
```

## Method 3: Windows Credential Manager

1. **Clear old credentials:**
   ```bash
   cmdkey /list
   ```
   Look for `git:https://github.com` entries

2. **Delete GitHub credentials:**
   ```bash
   cmdkey /delete:git:https://github.com
   ```

3. **Push (will prompt for credentials):**
   ```bash
   git push origin main
   ```
   - **Username:** `ranadheernakka` (or your GitHub username)
   - **Password:** Your Personal Access Token (NOT your GitHub password)

## Verify Push

After pushing, check:
- Visit: https://github.com/ranadheernakka/Urban-App-UI-Flutter-
- You should see all your files!

## Troubleshooting

### Error: 403 Forbidden
- You need write access to the repository
- Make sure you're using a token with `repo` scope
- Or get added as a collaborator to the repository

### Error: Authentication failed
- Clear credentials: `cmdkey /delete:git:https://github.com`
- Try again with a fresh token

### Error: Repository not found
- Make sure the repository exists
- Check you have access to it
- Verify the URL is correct

## Current Status

✅ Repository configured: `https://github.com/ranadheernakka/Urban-App-UI-Flutter-.git`
✅ 2 commits ready to push
✅ All files committed
⏳ Waiting for authentication

## Need Help?

- GitHub Token Guide: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
- Git Authentication: https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories

