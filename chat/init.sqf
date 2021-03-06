/**
 * Chat Module
 *
 * Description: This module is responsible for the blacklisting of certain
 * words in the chat.
 */

#define THIS_MODULE chat
#include "x_macros.sqf"

// Set words to be blacklisted.
GVAR(chat_blacklisted) = [
    "bad co",
    "elite warrior",
    "dimrod",
    "je007",
    "kev's"
];

MODULE(THIS_MODULE) = true;