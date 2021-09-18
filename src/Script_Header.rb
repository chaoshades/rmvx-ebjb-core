################################################################################
#                           EBJB Core - EBJB_Core                     #   VX   #
#                          Last Update: 2012/03/15                    ##########
#                         Creation Date: 2011/05/22                            #
#                          Author : ChaosHades                                 #
#     Source :                                                                 #
#     http://www.google.com                                                    #
#------------------------------------------------------------------------------#
#  Contains common functions and objects for different uses in the EBJB        #
#  scripts. You can use them as well for your needs.                           #
#==============================================================================#
#                         ** Instructions For Usage **                         #
#  There are settings that can be configured in the Core_Config class. For     #
#  more info on what and how to adjust these settings, see the documentation   #
#  in the class.                                                               #
#==============================================================================#
#                                ** Examples **                                #
#  See the documentation in each classes.                                      #
#==============================================================================#
#                           ** Installation Notes **                           #
#  Copy this script in the Materials section                                   #
#==============================================================================#
#                             ** Compatibility **                              #
#  Overwrites: Window_Selectable - initialize, index, create_contents, top_row #
#                                  page_row_max, cursor_down, cursor_up,       #
#                                  cursor_left, cursor_right, cursor_pagedown, #
#                                  cursor_pageup, item_rect, update_cursor,    #
#                                  update                                      #
#  Alias: Window_Selectable - call_update_help, cursor_movable?                #
################################################################################

$imported = {} if $imported == nil
$imported["EBJB_Core"] = true
