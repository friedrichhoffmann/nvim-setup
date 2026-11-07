#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/friedrichhoffmann/nvim-setup.git"
config_folder="nvim"
branch="main"

case "$(uname -m)" in
  x86_64|amd64) archive="nvim-linux-x86_64.tar.gz" ;;
  aarch64|arm64) archive="nvim-linux-arm64.tar.gz" ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

local_dir="$HOME/.local"
bin_dir="$local_dir/bin"
opt_dir="$local_dir/opt"
config_dir="$local_dir/config/nvim"
install_dir="$opt_dir/nvim"
tmp_dir=$(mktemp -d)

cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

for cmd in curl tar git; do
  command -v "$cmd" >/dev/null || {
    echo "Missing required command: $cmd" >&2
    exit 1
  }
done

mkdir -p "$bin_dir" "$opt_dir" "$local_dir/config"

echo "Downloading Neovim nightly..."
curl -fL --retry 3 \
  "https://github.com/neovim/neovim/releases/download/nightly/$archive" \
  -o "$tmp_dir/neovim.tar.gz"

mkdir "$tmp_dir/extracted"
tar -xzf "$tmp_dir/neovim.tar.gz" -C "$tmp_dir/extracted"

extracted_dir="$tmp_dir/extracted/${archive%.tar.gz}"
if [[ ! -x "$extracted_dir/bin/nvim" ]]; then
  echo "Neovim executable not found in downloaded archive." >&2
  exit 1
fi

rm -rf "$install_dir"
mv "$extracted_dir" "$install_dir"

echo "Downloading your Neovim config..."
git -C "$tmp_dir" init -q repo
git -C "$tmp_dir/repo" remote add origin "$repo_url"
git -C "$tmp_dir/repo" config core.sparseCheckout true
mkdir -p "$tmp_dir/repo/.git/info"
printf '%s/\n' "$config_folder" > "$tmp_dir/repo/.git/info/sparse-checkout"
git -C "$tmp_dir/repo" fetch --depth 1 origin "$branch"
git -C "$tmp_dir/repo" checkout -q FETCH_HEAD

if [[ ! -d "$tmp_dir/repo/$config_folder" ]]; then
  echo "Config folder '$config_folder' was not found in the repository." >&2
  exit 1
fi

rm -rf "$config_dir"
mkdir -p "$config_dir"
cp -a "$tmp_dir/repo/$config_folder/." "$config_dir/"

cat > "$bin_dir/nvim" <<'WRAPPER'
#!/usr/bin/env sh
export XDG_CONFIG_HOME="$HOME/.local/config"
exec "$HOME/.local/opt/nvim/bin/nvim" "$@"
WRAPPER
chmod +x "$bin_dir/nvim"

echo "Installed Neovim nightly and config."
echo "Run: $bin_dir/nvim"
echo "If needed, add ~/.local/bin to your PATH."

