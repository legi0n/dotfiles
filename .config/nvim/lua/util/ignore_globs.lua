local M = {}

M.globs = {
    -- Version control
    ".git/",

    -- Dependencies
    "node_modules/",
    "vendor/",
    ".venv/",
    "venv/",
    "env/",

    -- Build outputs
    "build/",
    "dist/",
    "out/",
    "target/",
    "bin/",
    "obj/",
    "coverage/",
    ".output/",
    ".cache/",

    -- Language and tool caches
    "__pycache__/",
    ".pytest_cache/",
    ".mypy_cache/",
    ".tox/",
    ".gradle/",
    ".eslintcache",
    ".prettier-cache",

    -- Binary and media files
    "*.{png,jpg,jpeg,gif,webp,ico,icns,bmp,tif,tiff,avif,heic}",
    "*.{pdf,ps,eps}",
    "*.{mp3,mp4,m4a,aac,ogg,flac,wav,wma,opus}",
    "*.{mov,mkv,avi,webm,wmv,mpeg,mpg}",
    "*.{ttf,otf,woff,woff2,eot}",
    "*.{zip,tar,gz,tgz,bz2,xz,7z,rar,zst}",
    "*.{sqlite,sqlite3,db,db3}",
    "*.{o,obj,a,lib,so,dll,dylib,exe,pyd}",
    "*.{pyc,pyo,class,jar,war,ear,wasm}",

    -- Generated and minified files
    "*.min.js",
    "*.min.css",
    "*.map",

    -- Temporary files
    "*.tmp",
    "*.swp",
    "*.swo",
    "*~",
}

function M.rg_args()
    local args = { "--hidden" }

    for _, glob in ipairs(M.globs) do
        vim.list_extend(args, { "--glob", "!" .. glob })
    end

    return args
end

return M
