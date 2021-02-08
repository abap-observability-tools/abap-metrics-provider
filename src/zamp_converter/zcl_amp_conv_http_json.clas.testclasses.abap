CLASS ltcl_test DEFINITION FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_amp_conv_http_json.

    METHODS setup.
    METHODS test_content_type FOR TESTING.
    METHODS test_without_metrics FOR TESTING.
    METHODS test_only_allowed_characters FOR TESTING.
    "! not allowed characters: https://www.tutorialspoint.com/json_simple/json_simple_escape_characters.htm
    METHODS test_special_characters FOR TESTING.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.


  METHOD test_only_allowed_characters.

    DATA metric_list TYPE zif_amp_converter=>metric_store.

    metric_list = VALUE #( ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k1' metric_value = 1 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k2' metric_value = 2 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k3' metric_value = 3 ) ).

    DATA(act_converted_metrics) = cut->zif_amp_converter~convert( metric_store = metric_list ).

    DATA(exp_converted_metrics) = |\{"NPL_001_s1_g1": \{"k1": 1, "k2": 2, "k3": 3\}\}|.

    CONDENSE act_converted_metrics NO-GAPS.
    CONDENSE exp_converted_metrics NO-GAPS.

    cl_aunit_assert=>assert_equals( exp = exp_converted_metrics
                                    act = act_converted_metrics
                                    msg  = |wrong json with only allowed characters| ).

  ENDMETHOD.

  METHOD test_special_characters.

    DATA metric_list TYPE zif_amp_converter=>metric_store.

    metric_list = VALUE #( ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k"1"' metric_value = 1 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\b2' metric_value = 2 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\f3' metric_value = 3 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\n4' metric_value = 4 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\r5' metric_value = 5 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\t6' metric_value = 6 )
                           ( metric_scenario = 's1' metric_group = 'g1' metric_key = 'k\7' metric_value = 7 ) ).

    DATA(act_converted_metrics) = cut->zif_amp_converter~convert( metric_store = metric_list ).

    DATA(exp_converted_metrics) = |\{"NPL_001_s1_g1": \{"k\\"1\\"": 1,| &&
                                                       |"k\\\\b2": 2,| &&
                                                       |"k\\\\f3": 3,| &&
                                                       |"k\\\\n4": 4,| &&
                                                       |"k\\\\r5": 5,| &&
                                                       |"k\\\\t6": 6,| &&
                                                       |"k\\\\7": 7\}\}|.

    CONDENSE act_converted_metrics NO-GAPS.
    CONDENSE exp_converted_metrics NO-GAPS.

    cl_aunit_assert=>assert_equals( exp = exp_converted_metrics
                                    act = act_converted_metrics
                                    msg  = |wrong json with special metrics| ).

  ENDMETHOD.

  METHOD setup.
    cut = NEW zcl_amp_conv_http_json( ).
  ENDMETHOD.

  METHOD test_content_type.

    DATA(exp_content_type) = |application/json|.

    cut->zif_amp_converter~convert( EXPORTING
                                        metric_store      = VALUE #( ( ) )
                                      IMPORTING
                                        content_type      = DATA(act_content_type) ).

    cl_aunit_assert=>assert_equals( exp = exp_content_type
                                    act = act_content_type
                                    msg = |wrong content type| ).

  ENDMETHOD.

  METHOD test_without_metrics.

    DATA(act_converted_metrics) = cut->zif_amp_converter~convert( metric_store = VALUE #( ) ).

    DATA(exp_converted_metrics) = |\{\}|.

    CONDENSE act_converted_metrics NO-GAPS.
    CONDENSE exp_converted_metrics NO-GAPS.

    cl_aunit_assert=>assert_equals( exp = exp_converted_metrics
                                    act = act_converted_metrics
                                    msg  = |wrong empty json| ).

  ENDMETHOD.

ENDCLASS.
