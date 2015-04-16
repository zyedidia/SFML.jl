ext = ""

@linux_only ext = "so"
@osx_only ext = "dylib"

run(`./createlib.sh libjuliasfml.$ext`)
