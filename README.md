# Dotfiles Management

A simple method to manage your dotfiles using a bare Git repository. This approach allows you to version control your configuration files without cluttering your home directory with a `.git` folder.

## Setup

### Starting from Scratch

If you haven't been tracking your configurations before, start with these steps:

```bash
git init --bare $HOME/dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
echo "alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

- The first line creates a bare Git repository in `~/dotfiles` to track your dotfiles
- The second line creates an alias `dot` which you'll use instead of the regular `git` command
- The third line sets a flag to hide untracked files when you do `dot status`
- The fourth line adds the alias to your `.bashrc` so it's available in new terminal sessions

### Installing on a New System

To install your dotfiles on a new system:

```bash
# Clone your dotfiles repository
git clone --bare <git-repo-url> $HOME/dotfiles

# Define the alias in the current shell scope
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Checkout the actual content from the bare repository to your $HOME
dot checkout
```

If you get an error message like:

```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
```

This is because your `$HOME` folder might already have some stock configuration files which would be overwritten. Back them up and try again:

```bash
mkdir -p .dotfiles-backup && \
dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}
```

Then run checkout again:

```bash
dot checkout
```

Set the flag to hide untracked files:

```bash
dot config --local status.showUntrackedFiles no
```

Add the alias to your shell configuration:

```bash
echo "alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

## Usage

Now you can manage your dotfiles with regular Git commands, but use `dot` instead of `git`:

```bash
# Check status
dot status

# Add files
dot add .vimrc
dot add .bashrc

# Commit changes
dot commit -m "Add vimrc and bashrc"

# Push to remote
dot push
```

## Examples

Track a new dotfile:
```bash
dot add .gitconfig
dot commit -m "Add git configuration"
dot push
```

Edit an existing dotfile:
```bash
vim .vimrc
dot add .vimrc
dot commit -m "Update vim configuration"
dot push
```

View your dotfiles history:
```bash
dot log --oneline
```

## Benefits

- **No extra tooling**: Uses standard Git commands
- **Clean home directory**: No `.git` folder cluttering your home directory  
- **Version control**: Full Git history for your configurations
- **Easy sync**: Simple to keep dotfiles synchronized across multiple machines
- **Selective tracking**: Only track the files you explicitly add

## Installation Script

You can create a simple installation script for new machines:

```bash
#!/bin/bash

# Clone dotfiles repository
git clone --bare https://github.com/yourusername/dotfiles.git $HOME/dotfiles

# Set up alias
echo "alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Backup existing dotfiles
mkdir -p $HOME/.dotfiles-backup
dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfiles-backup/{} 2>/dev/null

# Checkout dotfiles
dot checkout

# Hide untracked files
dot config --local status.showUntrackedFiles no

echo "Dotfiles installed successfully!"
```

## Tips

- Always use `dot` instead of `git` when managing your dotfiles
- Use `dot status` to see which dotfiles have been modified
- Be selective about which files you track - avoid adding large files or sensitive information
- Consider adding a `.gitignore` to exclude files you never want to track
- Use branches for different machine configurations if needed

## Troubleshooting

**Q: I accidentally used `git` instead of `dot`, what happens?**  
A: Nothing bad, but the commands won't work as expected since you're not in a regular Git repository.

**Q: How do I untrack a file I added by mistake?**  
A: Use `dot rm --cached <filename>` to remove it from tracking without deleting the file.

**Q: Can I use this method with multiple machines that have different configurations?**  
A: Yes! You can use different branches for different machines, or use conditional includes in your configuration files.
