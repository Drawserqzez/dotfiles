function get_logo()
    local user = vim.fn.system('git config get user.email')

    if string.match(user, 'centiro') then
        return {
            "MMMMMMMMMMMMMMMMWKkdc;'..          ..';cdOKWMMMMMMMMMMMMMMMM",
            "MMMMMMMMMMMMWXkl,.          ....          .,lkXWMMMMMMMMMMMM",
            "MMMMMMMMMMNkc.     ..;coxkO000000Okxoc;..     .ckNMMMMMMMMMM",
            "MMMMMMMWKo'     'cd0XWMMMMMMMMMMMMMMMMWX0xc'     'oKWMMMMMMM",
            "MMMMMMXo.    .ckXWMMMMMMMMMMMMMMMMMMMMMMMMMXkc.    .oXMMMMMM",
            "MMMMNk'    'dXWMMMMMMMMMMMMMMMMMMMMWNX0OkxxxkOxc.    'kNMMMM",
            "MMMXl.   .dXMMMMMMMMMMMMMMMMMMMMNOd:,..       ...     .lXMMM",
            "MMK:    :0WMMMMMMMMMMMMMMMMMW0xl'       .....           :KMM",
            "MK;   .lXMMMMMMMMMMMMMMMMMW0c.     .;lxO0KKK0Odl,.       ;KM",
            "Nc   .oNMMMMMMMMMMMMMMMMMNo.    .;xKWMMMMMMMMMMMWKd,      cN",
            "x.   cXMMMMMMMMMMMMMMMMMXc    .,kWMMMMMMMMMMMMMMMMMNd.    .x",
            ";   'OMMMMMMMMMMMMMMMMMNl    cOXMMMMMMMMMMMMMMMMMMMMW0;    ;",
            ".   cNMMMMMMMMMMMMMMMMMk.   :XMMMMMMMMMMMMMMMMMMMMMMMM0'   .",
            "   .dWMMMMMMMMMMMMMMMMNl   .kMMMMMMMMMMMMMMMMMMMMMMMMMWo    ",
            "   .kMMMMMMMMMMMMMMMMMX:   '0MMMMMMMMMMMMMMMMMMMMMMMMMMk.   ",
            "   .xMMMMMMMMMMMMMMMMMN:   'OMMMMMMMMMMMMMMMMMMMMMMMMMMx.   ",
            "    oWMMMMMMMMMMMMMMMMWd    oWMMMMMMMMMMMMMMMMMMMMMMMMX:    ",
            ".   ;XMMMMMMMMMMMMMMMMMK,   .kWWMMMMMMMMMMMMMMMMMMMMMNd.   .",
            "l   .dWMMMMMMMMMMMMMMMMWk.   .:xNMMMMMMMMMMMMMMMMMMMXl.    l",
            "0'   'OMMMMMMMMMMMMMMMMMWO'     ;kNMMMMMMMMMMMMMMMXx,     ,0",
            "Wx.   ,0MMMMMMMMMMMMMMMMMWKc.     ,oOXWWMMMMMWNKkc'      .kW",
            "MWd.   'kWMMMMMMMMMMMMMMMMMWOc,.     .,:clllc;'.        .xWM",
            "MMWx.   .lXMMMMMMMMMMMMMMMMMMWNKd:.                    .xWMM",
            "MMMW0;    'dXMMMMMMMMMMMMMMMMMMMMWX0xlc;,,,,;:c:'     ;0WMMM",
            "MMMMMXd.    'o0WMMMMMMMMMMMMMMMMMMMMMMMMWWWWN0o'    .dXMMMMM",
            "MMMMMMWKo.    .;d0NMMMMMMMMMMMMMMMMMMMMMMN0d;.    .oKMMMMMMM",
            "MMMMMMMMMXd;.    .'cok0XNWMMMMMMMMWNX0koc'.    .;dXMMMMMMMMM",
            "MMMMMMMMMMMN0o;.      ..';::cccc::;'..      .;o0NMMMMMMMMMMM",
            "MMMMMMMMMMMMMMWKkl;..                  ..;lkKWMMMMMMMMMMMMMM",
            "MMMMMMMMMMMMMMMMMMWKko:'..        ..':okKWMMMMMMMMMMMMMMMMMM",
        }

    else 
        return {
            [[             ...     ...                                                    .               ]],
            [[  .=*8888n.."%888:                                                 @88>                     ]],
            [[ X    ?8888f '8888                     u.        ...     ..        %8P      ..    .     :   ]],
            [[ 88x. '8888X  8888>       .u     ...ue888b    :~""888h.:^"888:      .     .888: x888  x888. ]],
            [['8888k 8888X  '"*8h.   ud8888.   888R Y888r  8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f`]],
            [[ "8888 X888X .xH8    :888'8888.  888R I888> X888n. 8888X  ?888>  ''888E`   X888  888X '888> ]],
            [[   `8" X888!:888X    d888 '88%"  888R I888> '88888 8888X   ?**h.   888E    X888  888X '888> ]],
            [[  =~`  X888 X888X    8888.+"     888R I888>   `*88 8888~ x88x.     888E    X888  888X '888> ]],
            [[   :h. X8*` !888X    8888L      u8888cJ888   ..<"  88*`  88888X    888E    X888  888X '888> ]],
            [[  X888xX"   '8888..: '8888c. .+  "*888*P"       ..XC.    `*8888k   888&   "*88%""*88" '888!`]],
            [[:~`888f     '*888*"   "88888%      'Y"        :888888H.    `%88>   R888"    `~    "    `"`  ]],
            [[    ""        `"`       "YP'                 <  `"888888:    X"     ""                      ]],
            [[                                                   %888888x.-`                              ]],
            [[                                                     ""**""                                 ]],
        }
    end
end
