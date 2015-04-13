os = ""
ext = ""

@linux_only begin
	os = "linux"
	ext = "so"
end
@osx_only begin
	os = "osx"
	ext = "dylib"
end

run(`./createlib.sh $os libjuliasfml.$ext`)
