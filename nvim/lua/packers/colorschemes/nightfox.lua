local palettes = {
  nightfox = {
  },
  duskfox = {
  },
  nordfox = {
    bg1 = '#1e2430'
  },
  terafox = {
  },
  carbonfox = {
  },
}
require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  },
  palettes = palettes
})
vim.cmd [[ colorscheme nordfox ]]
