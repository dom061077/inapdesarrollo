<?php

    /*static final String		EQ="eq";
    static final String		NOTEQUAL="ne";
    static final String 	LESSTHAN="lt";
    static final String 	LESSTHANEQUALS="le";
    static final String 	GREATERTHAN="gt";
    static final String 	GREATERTHANEQUALS="ge";
    static final String		ISIN="in";
    static final String		ISNOTIN="ni";
    static final String		CONTAINS="cn";
    static final String		DOESNOTCONTAIN="nc";
    static final String 	BEGINWITH="bw";
    */
    define ("EQ", "eq");
    define ("NOTEQUAL","ne");
    define ("LESSTHAN","le");
    define ("LESSTHANEQUALS","le");
    define ("GREATERTHAN","gt");
    define ("ISIN","in");
    define ("ISNOTIN","ni");
    define ("CONTAINS","cn");
    define ("DOESNOTCONTAIN","nc");
    define ("BEGINWITH","bw");

    class Utilidad {
        public static function array_push_withkey($array,$key,$value){
            $array[$key]=$value;
            return $array;
        }
        
        public static function getOperator($operator){
            $retorno = "";
            switch ($operator){
               case EQ:
                   $retorno = " = ";
                   break;
               case NOTEQUAL:
                   $retorno = " <> ";
                   break;
               case LESSTHAN:
                   $retorno = " < ";
                   break;
               case LESSTHANEQUALS:
                   $retorno = " <= ";
                   break;
               case GREATERTHAN:
                   $retorno = " >= ";
                   break;
               case ISIN:
                   
                   break;
               case ISNOTIN:
                   break;
               case CONTAINS:
                   break;
               case DOESNOTCONTAIN:
                   break;
               case BEGINWITH:
                   $retorno = " like ";
                   break;
            }
            return $retorno;
        }
    }




?>
