<?php
class ConexionConsulta
{
    static public function conectar()
    {
        $link = new PDO(
            'sqlsrv:Server=PROMETEO;Database=SIGH',
            'APL_EXT',
            'C0N3X10N@2020'
        );
        $link->exec("set names utf8");
        return $link;
    }
}
