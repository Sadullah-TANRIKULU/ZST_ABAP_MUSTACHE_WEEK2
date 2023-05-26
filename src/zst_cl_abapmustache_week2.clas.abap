CLASS zst_cl_abapmustache_week2 DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
    TYPES:
      BEGIN OF ty_street_fighter,
        fighter_name  TYPE string,
        special_skill TYPE string,
      END OF ty_street_fighter,
      ty_street_fighter_tt TYPE STANDARD TABLE OF ty_street_fighter WITH DEFAULT KEY,
      BEGIN OF ty_game,
        game_name TYPE string,
        fighters  TYPE ty_street_fighter_tt,
      END OF ty_game.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zst_cl_abapmustache_week2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lo_mustache TYPE REF TO zcl_mustache.
    DATA lt_fighter_data TYPE STANDARD TABLE OF ty_game WITH DEFAULT KEY.
    DATA lr_data TYPE REF TO ty_game.
    CONSTANTS: cu_newline TYPE c VALUE cl_abap_char_utilities=>newline.
    APPEND INITIAL LINE TO lt_fighter_data REFERENCE INTO lr_data.
    lr_data->game_name = `STREET FIGHTER ZERO`.
    lr_data->fighters = VALUE ty_street_fighter_tt(
        ( fighter_name  = `Ryu` special_skill = `HA DOU KE N` )
        ( fighter_name  = `Ken` special_skill = `SHO ER YOU KE N` )
        ( fighter_name  = `Sagat` special_skill = `TIGER CRASH` )
    ).
    APPEND INITIAL LINE TO lt_fighter_data REFERENCE INTO lr_data.
    lr_data->game_name = `STREET FIGHTER ALPHA`.
    lr_data->fighters = VALUE ty_street_fighter_tt(
        ( fighter_name  = `Chun Lee` special_skill = `YEP YEP` )
        ( fighter_name  = `Adon` special_skill = `JAGUAR KICK` )
        ( fighter_name  = `Charlie` special_skill = `SHOU FIRE` )
    ).
    TRY.
        lo_mustache = zcl_mustache=>create(
        '{{game_name}} by CAPCOM' && cu_newline &&
        '{{#fighters}}' && cu_newline &&
        '* {{fighter_name}} - {{special_skill}}' && cu_newline &&
        '{{/fighters}}' && cu_newline
                      ).
        out->write( lo_mustache->render( lt_fighter_data )  ).
      CATCH zcx_mustache_error.
        out->write( |something went wrong!!!| ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
