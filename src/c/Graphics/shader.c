#include <SFML/Graphics.h>

sfRenderStates* sjShader_setShader(sfShader* shader) {
	sfRenderStates* states = malloc(sizeof *states);
	states->shader = shader;
	states->blendMode = sfBlendAlpha;
	states->transform = sfTransform_Identity;
	states->texture = NULL

	return states;
}
