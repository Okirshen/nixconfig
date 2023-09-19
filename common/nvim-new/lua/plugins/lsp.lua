return {
	{
		'neovim/nvim-lspconfig',
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				lua_ls = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						},
					},
				},
			},
		},
		config = function(_, opts)
			for server, server_opts in pairs(opts.servers) do
				require("lspconfig")[server].setup(server_opts)
			end

			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = 'lsp-format-' .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)
					local bufnr = args.buf
					if not client.server_capabilities.documentFormattingProvider then
						return
					end


					vim.api.nvim_create_autocmd('BufWritePre', {
						group = get_augroup(client),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format { async = false, filter = function(c)
								return c.id == client.id
							end,
							}
						end,
					})
				end
			})
		end
	},
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },
}
