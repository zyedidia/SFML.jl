#include <stdlib.h>
#include <SFML/Graphics.h>

sfRenderStates* sjShader_setShader(sfBlendMode blendMode, sfShader* shader) {
	sfRenderStates* states = malloc(sizeof *states);
	states->shader = shader;
	states->blendMode = blendMode;
	states->transform = sfTransform_Identity;
	states->texture = NULL;

	return states;
}
