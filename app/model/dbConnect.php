<?php
class Conexion
{
	static public function conectar()
	{
		$link = new PDO(
			"mysql:host=localhost;dbname=db-psyemweb",
			"adm-psyem",
			'ldX7aMq4a$TS$7aBTKuDXD12'
		);
		$link->exec("set names utf8");
		return $link;
	}
}
