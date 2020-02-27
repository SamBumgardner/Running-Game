package util;

/**
    Exposes static functions to handle loading an Ogmo level.

    For now, this class will know enough about all possible objects to handle initialization
    reasonably well. In the long-term, it's probably better to have your game objects implement
    an interface that guarantees they can handle their own initialization from the data set in
    ogmo.

    To keep the possibility of dynamic level loading on the table, this class is restricted to
    just returning everything that should be added to the current state. It doesn't actually alter
    the currently active state in any way; the thing using this should be responsible for that.
**/
class OgmoLevelLoader {

    
}