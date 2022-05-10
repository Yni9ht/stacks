package gin

import (
	"universe.dagger.io/docker"
	"dagger.io/dagger/core"
)

#Instance: {
	input: #Input
	_file: core.#Source & {
		path: "template"
	}
	_manifests: core.#Source & {
		path: "manifests"
	}
	do: docker.#Copy & {
		"input":  input.image
		contents: _file.output
		dest:     "/scaffold/\(input.name)"
	}
	createDashboardManifest: docker.#Copy & {
		"input":  do.output
		contents: _manifests.output
		dest:     "/manifests/\(input.name)"
	}
	output: #Output & {
		image: createDashboardManifest.output
	}
}