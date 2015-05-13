#include <SFML/Graphics.h>

sfRenderStates sjShader_setShader(sfShader* shader) {
	sfRenderStates states = {sfBlendAlpha, sfTransform_Identity, NULL, shader};
	return states;
}
