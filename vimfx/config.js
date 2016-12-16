// Location bar search
(function() {
  let {commands} = vimfx.modes.normal
  function addSearchCommand([name, specialKeyword, keybind, description]) {
    console.log(name, specialKeyword, description)
    vimfx.addCommand({
      name: name,
      description: description,
      category: 'location',
      order: commands.focus_location_bar.order + 1
    }, (args) => {
      let {vim} = args
      let {gURLBar} = vim.window
      gURLBar.value = ''
      commands.focus_location_bar.run(args)
      gURLBar.value = specialKeyword
      gURLBar.onInput(new vim.window.KeyboardEvent('input'))
    });
    vimfx.set(`custom.mode.normal.${name}`, keybind);
  }

  for (let params of [
    [
      'search_by_tabs', '% ', 'gt',
      'Search for text in any open tabs'
    ], [
      'search_by_histories', '^ ', 'gh',
      'Search for text that matches results from the browser-histories'
    ], [
      'search_by_bookmarks', '* ', 'gb',
      'Search for text that matches any bookmarks'
    ]
  ]) {
    addSearchCommand(params);
  }
})();

// quick jumps
(function() {
  function addQuickMark([name, keybind, uri]) {
    vimfx.addCommand({
      name: name,
      description: `Open ${name} with new tab`
    }, ({vim}) => {
      vim.window.gBrowser.loadOneTab(uri)
    });

    vimfx.set(`custom.mode.normal.${name}`, keybind);
  }
  let qmarks = [
    ['addons', 'gja', 'about:addons'],
    ['preferences', 'gjp', 'about:preferences'],
    ['lastpass', 'gjl', 'chrome://lastpass/content/home2.xul']
  ];

  for (let qmark of qmarks) { addQuickMark(qmark); }
})();
