return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup {
      mode = "term",
      focus = true,
      filetype = {
        asm = {
          "nasm -f elf32 -o out.o $fileName &&",
          "ld -m elf_i386 -s -o out out.o &&",
          "./out",
        },
        cs = function(...)
          local root_dir = require("lspconfig").util.root_pattern "*.csproj"(vim.loop.cwd())
          return "cd " .. root_dir .. " && dotnet run$end"
        end,
      },
      -- startinsert = true,
    }
  end,
  lazy = false,
}
