[[ -d "build" ]] || mkdir build

alias ob="odin build src -out:build/Boids\ Debug"
alias obr="odin build src -out:build/Boids\ Debug && build/Boids\ Debug"
alias obo="odin build src -o:speed -out:build/Boids"
alias obor="odin build src -o:speed -out:build/Boids && build/Boids"
