#include <stdlib.h>
#include <SFML/Graphics.h>

sfRenderStates* sjRenderStates_create(sfBlendMode blendMode, sfShader* shader) {
    sfRenderStates* states = malloc(sizeof *states);
    states->shader = shader;
    states->blendMode = blendMode;
    states->transform = sfTransform_Identity;
    states->texture = NULL;

    return states;
}

void sjRenderStates_destroy(sfRenderStates* states) {
    free(states);
}

void sjRenderStates_setTexture(sfRenderStates* states, sfTexture* texture) {
    states->texture = texture;
}
