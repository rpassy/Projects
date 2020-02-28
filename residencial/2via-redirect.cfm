
<cfinclude  template="/residencial/header.cfm"> 


<div class="row">
   <div class="medium-9 medium-push-3 columns">
   <cfinclude  template="/residencial/menu.php">
   </div>
   <!--Close medium-9--> 
</div>

<div class="row">
      
         <div class="medium-3 columns">
         &nbsp;
         
         </div>
      
         
         <div class="medium-9 columns collapse">

	<!--- inicio do conteudo da pagina --->
<!---cfset cod = ((((cod/2551)-13)/59)-7)/13--->
<!---cfset cod = #codc#--->
<!---cfquery datasource="mls_dbwireless02" name="verifica"> local --->
<cfquery datasource="mls_dbwireless02" name="verifica">
	select nome, cod, cobranca, cobranca_old from cobra1 where md5(cod) = '#cod#'  
</cfquery>

<cfif verifica.recordcount is 0>
erro - c�digo inv�lido <cfabort>
</cfif>


<!--- and  nome= '#nome#'--->
<CFSET vencimento = ArrayNew(1)>
<CFSET vencimento20 = ArrayNew(1)>
<CFSET calcmes = ArrayNew(1)>
<cfset mm= #dateformat(now()+2,"mm")#> <!--- Os boletos estar�o dispon�veis somente a partir do dia 1 do mes corrente (+2 dois dias antes) --->
<cfset ano = '#mid(mes,6,2)#'>
<!--- cfoutput >
	#mid(mes,6,2)#
</cfoutput--->
<cfset aberto = 0>	

<cfset novovencimento = #DateFormat(Now()+1,"dd/mm/yy")#>
<cfset hoje = #DateFormat(Now())#>	

<!-- comentario para nao mostra a saida yes 
 <CFOUTPUT>
	 #ArrayAppend(calcmes, "jan")# #ArrayAppend(vencimento, "10/02/20")# #ArrayAppend(vencimento20, "20/02/20")# 
	 #ArrayAppend(calcmes, "fev")# #ArrayAppend(vencimento, "10/03/20")# #ArrayAppend(vencimento20, "20/03/20")# 
	 #ArrayAppend(calcmes, "mar")# #ArrayAppend(vencimento, "10/04/20")# #ArrayAppend(vencimento20, "20/04/20")# 
	 #ArrayAppend(calcmes, "abr")# #ArrayAppend(vencimento, "10/05/19")# #ArrayAppend(vencimento20, "20/05/19")# 
	 #ArrayAppend(calcmes, "mai")# #ArrayAppend(vencimento, "10/06/19")# #ArrayAppend(vencimento20, "20/06/19")# 
	 #ArrayAppend(calcmes, "jun")# #ArrayAppend(vencimento, "10/07/19")# #ArrayAppend(vencimento20, "20/07/19")# 
	 #ArrayAppend(calcmes, "jul")# #ArrayAppend(vencimento, "10/08/19")# #ArrayAppend(vencimento20, "20/08/19")# 
	 #ArrayAppend(calcmes, "ago")# #ArrayAppend(vencimento, "10/09/19")# #ArrayAppend(vencimento20, "20/09/19")# 
	 #ArrayAppend(calcmes, "set")# #ArrayAppend(vencimento, "10/10/19")# #ArrayAppend(vencimento20, "20/10/19")# 
	 #ArrayAppend(calcmes, "out")# #ArrayAppend(vencimento, "10/11/19")# #ArrayAppend(vencimento20, "20/11/19")# 
	 #ArrayAppend(calcmes, "nov")# #ArrayAppend(vencimento, "10/12/19")# #ArrayAppend(vencimento20, "20/12/19")# 
	 #ArrayAppend(calcmes, "dez")# #ArrayAppend(vencimento, "10/01/20")# #ArrayAppend(vencimento20, "20/01/20")# 
 </cfoutput> -->	

<cfif #mes# contains "jan">
	<cfset mc=1>
<cfelseif #mes# contains "fev">
	<cfset mc=2>
<cfelseif #mes# contains "mar">
	<cfset mc=3>
<cfelseif #mes# contains "abr">
	<cfset mc=4>
<cfelseif #mes# contains "mai">
	<cfset mc=5>
<cfelseif #mes# contains "jun">
	<cfset mc=6>
<cfelseif #mes# contains "jul">
	<cfset mc=7>
<cfelseif #mes# contains "ago">
	<cfset mc=8>
<cfelseif #mes# contains "set">
	<cfset mc=9>
<cfelseif #mes# contains "out">
	<cfset mc=10>
<cfelseif #mes# contains "nov">
	<cfset mc=11>
<cfelseif #mes# contains "dez">
	<cfset mc=12>
</cfif	>



<cfif verifica.cobranca is 'W' and verifica.cobranca_old is not 'M'>
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento1 = vencimento[mc]>
	<cfset diavenc1 = mid(vencimento[mc],1,2)>
	<cfset mesvenc1 = mid(vencimento[mc],4,2)>
	<cfset anovenc1 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'W' and verifica.cobranca_old is 'M'>
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento1 = vencimento20[mc]>
	<cfset diavenc1 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc1 = mid(vencimento20[mc],4,2)>
	<cfset anovenc1 = mid(vencimento20[mc],7,2)>	
<cfelseif verifica.cobranca is 'I' or verifica.cobranca is 'D' or verifica.cobranca is 'DR' or verifica.cobranca is 'WI'>
	<cfset mes= 'i_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento1 = vencimento[mc]>
	<cfset diavenc1 = mid(vencimento[mc],1,2)>
	<cfset mesvenc1 = mid(vencimento[mc],4,2)>
	<cfset anovenc1 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'S0' or verifica.cobranca is 'S1' or verifica.cobranca is 'S2' or verifica.cobranca is 'S4'>
	<cfset mes= 'h_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento1 = vencimento[mc]>
	<cfset diavenc1 = mid(vencimento[mc],1,2)>
	<cfset mesvenc1 = mid(vencimento[mc],4,2)>
	<cfset anovenc1 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'M'>
	<cfset mes= 'h_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento1 = vencimento20[mc]>
	<cfset diavenc1 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc1 = mid(vencimento20[mc],4,2)>
	<cfset anovenc1 = mid(vencimento20[mc],7,2)>
</cfif>

<!--- C�lculo do atraso --->
<cfset vencformat1 = '#mesvenc1#'&'/'&'#diavenc1#'&'/'&'#anovenc1#'>
<cfset vencimento1df = dateformat(vencformat1)>
<cfset atraso1 = DateDiff("d", vencimento1df, hoje)> 
<cfif atraso1 le 0>
	<cfset atraso1 =0>
</cfif>
<!--- Fim --->

<!--- Tira a multa / atraso se o dia 10 cai no fim de semana --->
<cfif DayOfWeek(hoje) eq 2 AND ( atraso1 eq 1 or atraso1 eq 2)>
<cfset atraso1 =0>
</cfif>
<!--- Fim --->
<!--- somente para feriado de 12 fevereiro de 2018 carnaval
<cfif DayOfWeek(hoje) eq 4 AND ( atraso1 eq 2 or atraso1 eq 3 or atraso1 eq 4)>
<cfset atraso1 =0>
</cfif> --->

<cfset mes1=#mes#>
<cfquery datasource="mls_dbwireless02" name="lista" >
select #mes#.username, cod, codcli, endereco, nnumero, nbanco, cobranca,  bairro, cep, #mes#.valor, pago from #mes#, cobra1 
where md5(cod)='#cod#' and cobra1.cod=#mes#.codcli
</cfquery>



 
 
		<cfif verifica.recordcount is 0>
      	<!---cfoutput>#verifica.nome#</cfoutput><br /--->
      	&nbsp;&nbsp;O sistema apresentou  um problema com o seu código. <br />
        &nbsp;&nbsp;Por favor entre em contato com o setor administrativo pelo telefone 2538-8400
        <cfelse>
        
        </cfif>
  		<table width="600" border=0>
        <cfoutput query="lista">
        <cfset aberto = 1>
        <cfset valorcorrigido1 =numberformat(valor*(1.02 + atraso1*0.01/30),"99999.99")>

        <form method="post" action="/includes/fatura.cfm" name="form1">
        <!--- <form name="form1" method="post" action="/boleto/boleto_online.php" target="_blank"> --->
        <input type="hidden" name="cod" value="#cod#">
        <input type="hidden" name="mes" value="#mes1#">

        <input type="hidden" name="nome" value="#verifica.nome#">
        <input type="hidden" name="endereco" value="#endereco#">
        <cfif atraso1 gt 0>
			<input type="hidden" name="valor" value="#trim(valor)#"> <!--- era valorcorrigido1 e passou para valor em out18 pois os banco fazem o calculo --->
            <input type="hidden" name="vencimento" value="#vencimento1#"> <!--- era novovencimento e passou para vencimento em abril de 2019 --->
		<cfelse>
			<input type="hidden" name="valor" value="#valor#">
			<input type="hidden" name="vencimento" value="#vencimento1#">
		</cfif>
        <input type="hidden" name="nbanco" value="#nbanco#">
        <input type="hidden" name="nnumero" value="#nnumero#">

        <input type="hidden" name="cobranca" value="#cobranca#">
        <input type="hidden" name="bairro" value="#bairro#">
        <input type="hidden" name="cep" value="#cep#">
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Nome:</td>
        <td width="60%" align="left" class="texto-cinza-quadro valign="top">#verifica.nome#</td>
        <td width="40%" rowspan="3" align="left" valign="top"></td>
        </tr>
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Valor:</td>
        <td width="60%" align="left" class="texto-cinza-quadro valign="top">#numberformat(valor,"9999.99")#</td>
        <td width="40%" rowspan="3"  align="left" valign="top"></td>
        </tr>
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Vencimento:</td>
        <td width="60%" align="left" class="texto-cinza-quadro valign="top">#vencimento1#</td>
        <!---td width="40%" rowspan="3" align="left" valign="top"></td--->
        </tr>
        <cfif atraso1 gt 0>
            <!---tr> Retirado em out18 devido a diferenca do calculo do banco
            <td width="40%" align="left" class="texto-vermelho-quadro">Valor Corrigido:</td>
            <td width="60%" align="left" class="texto-vermelho-quadro" valign="top">#valorcorrigido1#</td>
            <td width="40%" rowspan="3" align="left" valign="top"></td>
            </tr--->
            <!---tr>
            <td width="40%" align="left" class="texto-vermelho-quadro">Novo Vencimento:</td>
            <td width="60%" align="left" class="texto-vermelho-quadro" valign="top">#novovencimento#</td>
            <td width="40%" rowspan="3" align="left" valign="top"></td>
            </tr--->
            <tr>
            <td width="40%" align="left" class="texto-cinza-quadro">Atraso:</td>
            <td width="60%" align="left" class="texto-cinza-quadro valign="top">#atraso1# dias</td>
            <td width="40%" rowspan="3" align="left" valign="top"></td>
            </tr>
        </cfif>
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Documento:</td>
        <td width="60%" align="left" class="texto-cinza-quadro valign="top">#nnumero#</td>
        <!---td width="40%" rowspan="3" align="left" valign="top"></td--->
        </tr>
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Referente:</td>
        <td width="60%" align="left" class="texto-cinza-quadro valign="top">#mes1#</td>
        <td width="40%" rowspan="3" align="left" valign="top"></td>
        </tr>
        <tr>
        <td width="40%" align="left" class="texto-cinza-quadro">Boleto:</td>
        <cfif len(nbanco) gt 1>
        	<td width="60%" align="left" class="texto-cinza-quadro valign="top">#nbanco#</td>
        	<cfif pago>
        		<td width="40%" align="left" class="texto-cinza-quadro valign="top">Quitado</td>	
        	<cfelse>	
        		<td width="40%" align="left" class="texto-cinza-quadro valign="top"><input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" ></td>
        	</cfif>	
        <cfelse>
        	<cfif verifica.cobranca is 'W'>
        		<td width="60%" align="left" class="texto-cinza-quadro valign="top"><Aguardando confirma��o do Banco</td>
        	<cfelse>
        		<td width="60%" align="left" class="texto-cinza-quadro valign="top">#nnumero#</td> 
        		<cfif pago>
        			<td width="40%" align="left" class="texto-cinza-quadro valign="top">Quitado</td>	
        		<cfelse>	
        			<td width="40%" align="left" class="texto-cinza-quadro valign="top"><input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" ></td>
        	</cfif>
        	</cfif>	
        </cfif>		
        </td>

        </tr>
        <!---CFLOCATION URL="/boleto/boleto_online.php?nome=#verifica.nome#&endereco=#endereco#&valor=#valor#&nbanco=#nbanco#&nnumero=#nnumero#&vencimento=#vencimento1#&cobranca=#cobranca#&bairro=#bairro#&cep=#cep#"--->
        
        <!--- nbanco s� para a bradesco , HSBC n�o tem nbanco --->
        <!---cfif (len(nbanco) gt 1 or verifica.cobranca is 'S0' or verifica.cobranca is 'S1' or verifica.cobranca is 'S2' or verifica.cobranca is 'S4' or verifica.cobranca is 'M') and not pago>
        <tr>	
        <td width="40%" align="left" class="texto-cinza-quadro" valign="top">
        	<input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" ></td>
        </tr>	
        </cfif--->
        <script>
		<cfif len(nbanco) gt 1 and pago is 'false' >
        document.form1.submit();
		</cfif>
        </script>
        
        </form>
        </cfoutput>	
        
       
                          
		</table>


</div>
</div>
	<!--- final do conteudo da pagina --->
<cfinclude template="/residencial/footer.php">
		
