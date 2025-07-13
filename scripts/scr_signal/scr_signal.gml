//credit: u/refreshertowel on reddit
//https://www.reddit.com/r/gamemaker/comments/1f5qqii/how_to_use_signals_in_gamemaker_and_what_the_hell/
//
//added my own comments :)

	
enum signal_returns {
    LST_ADDED,
    LST_ALREADY_EXISTS,
    LST_REMOVED_FROM_SIGNAL,
    LST_REMOVED_COMPLETELY,
    LST_NOT_SUBSCRIBED_TO_SIGNAL,
    LST_DOES_NOT_EXIST_IN_SIGNAL,
    LST_DOES_NOT_EXIST,
    SGL_DOES_NOT_EXIST,
    SGL_NOT_SENT_NO_SGL,
    SGL_NOT_SENT_NO_LST,
    SGL_SENT
}

#macro SIGNALS global.__signals

function SignalController() constructor {
    static __listeners = {};
	
	//Add a listener to a specific signal, with a specific callback action
	//to execute when signal is received
	//
	//array is stored like listener, callback action, listener, callback action
	//to save read/write time
    static __add_listener = function(_id, _signal, _callback) {
        if (!struct_exists(__listeners, _signal)) {
            __listeners[$ _signal] = [];
        }
        var _listeners = __listeners[$ _signal];
        for (var i = 0; i < array_length(_listeners); i += 2) {
            if (_listeners[i] == _id) {
                return signal_returns.LST_ALREADY_EXISTS;
            }
        }
        array_push(_listeners, _id, _callback);
        return signal_returns.LST_ADDED;
    }

    static __remove_listener_from_signal = function(_id, _signal) {
        if (!struct_exists(__listeners, _signal)) {
            return signal_returns.SGL_DOES_NOT_EXIST;
        }
        var _listeners = __listeners[$ _signal];
        var _found = false;
        for (var i = array_length(_listeners) - 2; i >= 0; i -= 2) {
            if (_listeners[i] == _id) {
                array_delete(_listeners, i, 2);
                _found = true;
                break;
            }
        }
        if (!_found) {
            return signal_returns.LST_DOES_NOT_EXIST_IN_SIGNAL;
        }
        return signal_returns.LST_REMOVED_FROM_SIGNAL;
    }

    static __remove_listener = function(_id) {
        var _names = struct_get_names(__listeners);
        var _found = false;
        for (var i = 0; i < array_length(_names); i++) {
            var _listeners = __listeners[$ _names[i]];
            for (var j = array_length(_listeners) - 1; j >= 0; j--) {
                if (_listeners[j] == _id) {
                    array_delete(_listeners, j, 2);
                    _found = true;
                    break;
                }
            }
        }
        if (!_found) {
            return signal_returns.LST_DOES_NOT_EXIST;
        }
        return signal_returns.LST_REMOVED_COMPLETELY;
    }
	//Signal data is any extra information sent, will be passed as an argument for the callback
    static __signal_send = function(_signal, _signal_data) {
        if (!struct_exists(__listeners, _signal)) {
            return signal_returns.SGL_NOT_SENT_NO_SGL;
        }
        var _listeners = __listeners[$ _signal];
        if (array_length(_listeners) <= 0) {
            return signal_returns.SGL_NOT_SENT_NO_LST;
        }
        for (var i = array_length(_listeners) - 2; i >= 0; i -= 2) {
            var _id = _listeners[i];
            with (_id) {
                _listeners[i + 1](_signal_data);
            }
        }
        return signal_returns.SGL_SENT;
    }
}


function SignalSubscribe(_id, _signal, _callback) {
    return SIGNALS.__add_listener(_id, _signal, _callback);
}
 
function SignalUnsubscribe(_id, _signal) {
    return SIGNALS.__remove_listener_from_signal(_id, _signal);
}
 
function SignalRemove(_id) {
    return SIGNALS.__remove_listener(_id);
}
 
function SignalSend(_signal, _signal_data = undefined) {
    return SIGNALS.__signal_send(_signal, _signal_data);
}