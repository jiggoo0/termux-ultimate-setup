# 🚀 Termux Ultimate Setup

Ultra-fast Termux configuration for developers.  
Installs **Oh My Zsh**, essential plugins, Autojump, and custom ASCII banner.

---

## ⚡ Quick Install

```bash
git clone https://github.com/jiggoo0/termux-ultimate-setup.git
cd termux-ultimate-setup
bash setup.sh


---

🔧 Features

Oh My Zsh with Avit theme

Plugins:

git, npm, history

zsh-autosuggestions

zsh-syntax-highlighting

zsh-completions

autojump


Custom ASCII banner

LightningCSS fix for Termux

Lean and fast configuration

Predefined aliases for Termux tasks



---

📝 Post-Install

source ~/.zshrc

or restart Termux.

Common Aliases

Command	Description

update	Update Termux packages
upgrade	Upgrade Termux packages
reload	Reload zsh configuration
proj	Quick jump to ~/project folder



---

🛠 Troubleshooting

zsh: command not found → export PATH=$HOME/.oh-my-zsh/bin:$PATH && source ~/.zshrc

Plugin not loading → check ~/.oh-my-zsh/custom/plugins

Banner broken → check Termux font UTF-8 support

Setup fails → re-run bash setup.sh



---

⚙️ Customization

Edit ZSH_THEME or plugins=(...) in .zshrc

Replace banner.txt for custom ASCII art

Add aliases in .zshrc



---

🔄 Update Script

cd ~/termux-ultimate-setup
git pull
bash setup.sh


---

⚙️ Contributing

See CONTRIBUTING.md for guidelines.


---

📄 License

MIT License
