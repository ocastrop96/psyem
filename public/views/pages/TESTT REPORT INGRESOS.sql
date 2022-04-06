

SELECT
		A.IdCuentaAtencion,P.NroDocumento,P.NroHistoriaClinica,TNI.Descripcion AS TipoNumeracion,P.ApellidoPaterno,P.ApellidoMaterno,
		P.PrimerNombre,P.SegundoNombre,TS.Descripcion AS TIPO_SEXO,A.EDAD,TE.Codigo AS TIPOS_EDAD,DP.Nombre AS DEPARTAMENTO,PV.Nombre AS PROVINCIA,
		D.Nombre AS DISTRITO,
		CP.Nombre AS CENTRO_POBLADO,
		FF.IdFuenteFinanciamiento AS CODIGO_SEGURO,FF.Descripcion AS TIPO_SEGURO,
		EA.FECHAINGRESO,CONVERT(VARCHAR, EA.FechaIngreso, 108) HORA_INGRESO,EA.FechaEgreso,
		CONVERT(VARCHAR, EA.FechaEgreso, 108) AS HORA_EGRESO,
		toa.Descripcion AS ORIGEN_INGRESO,
		CA.DESCRIPCION AS TIPO_C_ALATA,
		SI.Codigo AS COD_SI,
		SI.Nombre AS SER_ING,
		SE.Codigo AS COD_SE,
		SE.Nombre AS SER_EGRE,
		TCA.Descripcion AS CONDICION_ALTA ,
		TDA.Descripcion AS DESTINO_ALTA,
		DI.CodigoCIE10 AS CODIGO_CI_10,
		DI.Descripcion AS CI_NO_MONBRE, 
		ttd.Descripcion AS Tipo_Diagnostico,
		(
		     SELECT Prueba FROM (SELECT TD.Descripcion AS Prueba,
               ROW_NUMBER() OVER (PARTITION BY Att.IdAtencion ORDER BY (tarec.Fecha_Resultado) ASC)  AS RowNum 
			   FROM TAB_AtenResultado_Episodio_Cov19 tarec 
			   INNER JOIN EpisodioAtencion ea ON ea.IdEpisodio=tarec.idEpidosio
			   INNER join Atenciones att ON att.IdAtencion=ea.IdAtencion
	           INNER JOIN tb_tiposResultados tr ON tarec.IdResultado=TR.Idresultado
			   INNER JOIN tb_Despistaje td ON TD.IdPruebas=tarec.IdTipoMuestra
			   WHERE att.IdCuentaAtencion=a.IdCuentaAtencion)X WHERE RowNum=1
			   ) AS TipoPrueba,
		(
		  SELECT resuldato FROM (SELECT tr.Descripcion AS resuldato ,
            ROW_NUMBER() OVER (PARTITION BY Att.IdAtencion ORDER BY (tarec.Fecha_Resultado) ASC)  AS RowNum 
			FROM TAB_AtenResultado_Episodio_Cov19 tarec 
			INNER JOIN EpisodioAtencion ea ON ea.IdEpisodio=tarec.idEpidosio
			INNER join Atenciones att ON att.IdAtencion=ea.IdAtencion
	        INNER JOIN tb_tiposResultados tr ON tarec.IdResultado=TR.Idresultado
			INNER JOIN tb_Despistaje td ON TD.IdPruebas=tarec.IdTipoMuestra
			WHERE att.IdCuentaAtencion=a.IdCuentaAtencion)X WHERE RowNum=1
		) AS Resultado,
		TGI.IdTipoGravedad AS TiposPrioridaIngreso,
		ISNULL(ei.ApellidoPaterno,'')+' '+ISNULL(ei.ApellidoMaterno,'')+' '+ISNULL(ei.Nombres,'') AS Usuario_Ingreso,
		 CASE WHEN a.idFuenteFinanciamiento=1 then ISNULL((
			SELECT ISNULL(SUM(fosp1.Total),0) FROM FactOrdenServicio fos  
			INNER JOIN FactOrdenServicioPagos fosp ON fos.IdOrden=fosp.idOrden
			INNER JOIN FacturacionServicioPagos fosp1 ON fosp1.idOrdenPago=FOSP.idOrdenPago
			WHERE fos.IdCuentaAtencion=A.IdCuentaAtencion  AND FOS.IdEstadoFacturacion=1
				 ),0)+ISNULL((
				 SELECT ISNULL(sum(fbp.TotalPagar),0) from FactOrdenesBienes fob
				 INNER JOIN FacturacionBienesPagos fbp ON fob.idOrden=fbp.IdOrden
				 WHERE fob.idCuentaAtencion=A.IdCuentaAtencion  AND fob.idEstadoFacturacion=1  AND  fob.MovNumero IS NOT null
				 ),0)  
				 ELSE fca.TotalPorPagar END  as Deuda
		,ec.Descripcion AS EstadoCuenta,SF.FuaDisa+' - '+SF.FuaNumero AS NroFua,ece.Descripcion as Causa_Ingresa,ptf.Descripcion as Tipo_Financiamiento,
        (select top 1 dd.CodigoCIE10 from EpisodioAtencion eaa 
		inner join  AtencionesDiagnosticos adc on eaa.IdEpisodio=adc.Idepisodio
		inner join Diagnosticos dd on dd.IdDiagnostico=adc.IdDiagnostico
		where adc.IdClasificacionDx=3 and adc.IdSubclasificacionDx=301
		and eaa.IdEpisodio=ea.IdEpisodio) as Diag_Principal,
		(select top 1 dd.CodigoCIE10 from EpisodioAtencion eaa 
		inner join  AtencionesDiagnosticos adc on eaa.IdEpisodio=adc.Idepisodio
		inner join Diagnosticos dd on dd.IdDiagnostico=adc.IdDiagnostico
		where adc.IdClasificacionDx=3 and adc.IdSubclasificacionDx=302
		and eaa.IdEpisodio=ea.IdEpisodio) as Diag_Secundaria,
		(select top 1 dd.CodigoCIE10 from EpisodioAtencion eaa 
		inner join  AtencionesDiagnosticos adc on eaa.IdEpisodio=adc.Idepisodio
		inner join Diagnosticos dd on dd.IdDiagnostico=adc.IdDiagnostico
		where adc.IdClasificacionDx=4 and adc.IdSubclasificacionDx=303
		and eaa.IdEpisodio=ea.IdEpisodio) as Diag_Causa_Final
		from atenciones a
		INNER JOIN Pacientes P ON P.IdPaciente=A.IdPaciente
		LEFT JOIN PacientesDatosAdicionales  PDA ON PDA.IdPaciente=P.IdPaciente
		inner join EpisodioAtencion ea on a.IdAtencion=ea.IdAtencion
		inner join FuentesFinanciamiento ff on a.idFuenteFinanciamiento=ff.IdFuenteFinanciamiento
		INNER JOIN Servicios SI ON SI.IdServicio=EA.IdservicioIngreso
		INNER JOIN Especialidades ES ON ES.IdEspecialidad=SI.IdEspecialidad
		INNER JOIN DepartamentosHospital DPO ON DPO.IdDepartamento=ES.IdDepartamento
		LEFT JOIN Servicios SE ON SE.IdServicio=EA.IdservicioIngreso
		LEFT JOIN TiposSexo TS ON TS.IdTipoSexo=P.IdTipoSexo
		LEFT JOIN TiposEdad TE ON TE.IdTipoEdad=A.IdTipoEdad
		LEFT JOIN CentrosPoblados CP ON  CP.IdCentroPoblado=P.IdCentroPobladoDomicilio
		LEFT JOIN DISTRITOS D ON D.IdDistrito=P.IdDistritoDomicilio
		LEFT JOIN Provincias PV ON PV.IdProvincia=D.IdProvincia
		LEFT JOIN Departamentos DP ON DP.IdDepartamento=PV.IdDepartamento
		LEFT JOIN TiposAlta CA ON CA.IdTipoAlta=EA.IdTipoAlta
		LEFT JOIN TiposNumeracionHistoria TNI ON TNI.IdTipoNumeracion=P.IdTipoNumeracion
		LEFT JOIN TiposCondicionAlta TCA ON TCA.IdCondicionAlta=ea.IdCondicionAlta
		left join TiposDestinoAtencion TDA ON TDA.IdDestinoAtencion=ea.IdDestinoAtencion
		LEFT JOIN AtencionesDiagnosticos DA ON DA.Idepisodio=EA.IdEpisodio AND DA.IdClasificacionDx=2 AND DA.IdSubclasificacionDx=301
		LEFT JOIN Diagnosticos DI ON DI.IdDiagnostico=DA.IdDiagnostico
		LEFT JOIN Tb_TiposDiagnostico ttd ON ttd.Id=di.IdTipoDiagnostico
		LEFT JOIN HistoriasClinicas HC ON HC.NroHistoriaClinica=P.NroHistoriaClinica
		LEFT JOIN TiposGravedadAtencion TGI ON TGI.IdTipoGravedad=a.IdTipoGravedad
		LEFT JOIN Empleados ei ON ei.IdEmpleado=ea.SG_LOG_CRE_USUARIO
		INNER JOIN FacturacionCuentasAtencion fca ON fca.IdCuentaAtencion=a.IdCuentaAtencion
		INNER JOIN EstadosCuenta ec ON ec.IdEstado=fca.IdEstado
		LEFT JOIN TiposOrigenAtencion toa ON a.IdOrigenAtencion = toa.IdOrigenAtencion
		LEFT JOIN SIGH_EXTERNA..SisFuaAtencion SF ON SF.idCuentaAtencion=A.IdCuentaAtencion
		left join AtencionesEmergencia ae on ae.IdAtencion=a.IdAtencion
		left join EmergenciaCausaExternaMorbilidad ece on ece.IdCausaExternaMorbilidad=ae.IdCausaExternaMorbilidad
		left join tb_PacienteTiposFinanciamiento ptf on ptf.Id=p.IdTipoSeguro
		where 
		--convert(datetime,convert(varchar(10),ea.FechaIngreso,103),103) BETWEEN @FechaInicio AND @FechaFin
		 convert(datetime,CONVERT(varchar(10),EA.FechaIngreso, 103),103) BETWEEN  convert(datetime,CONVERT(varchar(10),'2022-03-01 00:00:00', 103),103)   AND convert(datetime,CONVERT(varchar(10), '2022-03-30 00:00:00', 103),103) 
		and ea.IdTipoServicio= 2
		--AND (DPO.IdDepartamento=@Departamento OR @Departamento=-100)
		--AND (ES.IdEspecialidad=@Especialidad OR @Especialidad=-100)
		--AND (SE.IdServicio=@IdServicio OR @IdServicio=-100)
		--AND (A.idFuenteFinanciamiento=@IdfuenteFinanciaminto OR @IdfuenteFinanciaminto=-100)
		--AND (A.IdTipoGravedad=@IdGravedad OR @IdGravedad=-100)
		--AND (HC.IdTipoNumeracion=@IdTipoNumeracion OR @IdTipoNumeracion=-100)
		--AND (ae.IdCausaExternaMorbilidad=@IdMorbilidad OR @IdMorbilidad=-100)
		AND A.idEstadoAtencion<>0