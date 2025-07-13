function pause(mode) {
    switch (mode) {
        case pM.none: return false;
        case pM.editor: return global.editorPause;
        case pM.pauseMenu: return global.pause;
        case pM.transition: return global.transitionPause;
        case pM.editor_pauseMenu: return global.editorPause || global.pause;
        case pM.editor_transition: return global.editorPause || global.transitionPause;
        case pM.pauseMenu_transition: return global.pause || global.transitionPause;
        case pM.all: return global.editorPause || global.pause || global.transitionPause;
        default: return false;
    }
}

