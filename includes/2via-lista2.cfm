
        
         <h1>Segunda via do Boleto</h1>
<!---cfquery datasource="mls_dbwireless02" name="verifica"> local --->
<cfquery datasource="mls_dbwireless02" name="verifica">
	select nome, cod, cobranca, cobranca_old, cgc from cobra1 
	where cod = #cod#
</cfquery>
<cfquery datasource="mls_dbwireless02" name="notas">
	select * from notas 
	where codcli = #cod#  
</cfquery>

<cfif ParameterExists(form.CGC)>
<cfset cgc2 =  #REPLACELIST(form.CGC,     "-,.,/,_,\, ,",",,,,,,")#> 
</cfif>

<cfif ParameterExists(CGC)>
<cfset cgc2 =  #REPLACELIST(CGC,     "-,.,/,_,\, ,",",,,,,,")#> 
</cfif>


<cfset cgc_limpo = #REPLACELIST(verifica.cgc,     "-,.,/,_,\, ,",",,,,,,")#>

<!---- <cfoutput> verifica   #verifica.cgc#  -   cgc_limpo -  #cgc_limpo#   -  cgc form  #cgc2#</cfoutput>---->
<cfif cgc_limpo is '#cgc2#'>


<!--- and  nome= '#nome#'--->
<CFSET vencimento = ArrayNew(1)>
<CFSET vencimento20 = ArrayNew(1)>
<CFSET calcmes = ArrayNew(1)>
<cfset mm= #dateformat(now()+10,"mm")#> <!--- Os boletos estarão disponíveis somente a partir do dia 1 do mes corrente (+2 dois dias antes) --->

<cfset ano_corrente = '20'> <!--- ATENCAO ATUALIZAR O ANO SOMENTE AQUI --->
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
	 #ArrayAppend(calcmes, "dez")# #ArrayAppend(vencimento, "10/01/19")# #ArrayAppend(vencimento20, "20/01/19")# 
 </cfoutput> -->	

<cfset mc = mm-1>
<cfif mc is 0>
	<cfset mc = 12>
</cfif>
<cfif mm lt 2>
	<cfset ano = ano_corrente -1>
<cfelse>
	<cfset ano = ano_corrente>	
</cfif>

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
<cfset vencformat1 = '#mesvenc1#'&'/'&'#diavenc1#'&'/'&'#anovenc1#'>
<cfset vencimento1df = dateformat(vencformat1)>
<cfset atraso1 = DateDiff("d", vencimento1df, hoje)> 
<cfif atraso1 le 0>
	<cfset atraso1 =0>
</cfif>


<!--- Tira a multa / atraso se o dia 10 cai no fim de semana --->
<cfif DayOfWeek(hoje) eq 2 AND ( atraso1 eq 1 or atraso1 eq 2)>
<cfset atraso1 =0>
</cfif>
<!--- Fim --->

<!--- somente para feriado de 12 fevereiro de 2018 carnaval 
<cfif DayOfWeek(hoje) eq 4 AND ( atraso1 eq 2 or atraso1 eq 3 or atraso1 eq 4)>
<cfset atraso1 =0>
</cfif> --->

<cfoutput> </cfoutput>
<cfset mes1=#mes#>
<cfquery datasource="mls_dbwireless02" name="lista" >
select #mes#.username, cod, codcli, endereco, nnumero, nbanco, cobranca,  bairro, cep, #mes#.valor, pago from #mes#, cobra1 
where cod = #cod# and cod=codcli and pago ='False'
</cfquery>

<!---cfoutput>#lista.nbanco# --------- #lista.nnumero#</cfoutput--->

<cfset mc = mm-2>
<cfif mc LTE 0>
	<cfset mc = 12+mm-2>
</cfif>
<cfif mm lt 3>
	<cfset ano = ano_corrente -1>
<cfelse>
	<cfset ano = ano_corrente>		
</cfif>



<cfif verifica.cobranca is 'W' and  "I,D,DR,WI,W" contains verifica.cobranca_old>
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento[mc]>
	<cfset diavenc2 = mid(vencimento[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento[mc],4,2)>
	<cfset anovenc2 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'W' and  "S0,S1,S2,S4" contains verifica.cobranca_old>  <!--- trocar para c_ em dezembro --->
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento[mc]>
	<cfset diavenc2 = mid(vencimento[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento[mc],4,2)>
	<cfset anovenc2 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'W' and verifica.cobranca_old is 'M'> <!--- trocar para c_ em dezembro --->
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento20[mc]>
	<cfset diavenc2 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento20[mc],4,2)>
	<cfset anovenc2 = mid(vencimento20[mc],7,2)>	
<cfelseif verifica.cobranca is 'I' or verifica.cobranca is 'D' or verifica.cobranca is 'DR' or verifica.cobranca is 'WI'>
	<cfset mes= 'i_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento[mc]>
	<cfset diavenc2 = mid(vencimento[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento[mc],4,2)>
	<cfset anovenc2 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'S0' or verifica.cobranca is 'S1' or verifica.cobranca is 'S2' or verifica.cobranca is 'S4'>
	<cfset mes= 'h_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento[mc]>
	<cfset diavenc2 = mid(vencimento[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento[mc],4,2)>
	<cfset anovenc2 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'M'>
	<cfset mes= 'h_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento2 = vencimento20[mc]>
	<cfset diavenc2 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc2 = mid(vencimento20[mc],4,2)>
	<cfset anovenc2 = mid(vencimento20[mc],7,2)>
</cfif>
<cfset vencformat2 = '#mesvenc2#'&'/'&'#diavenc2#'&'/'&'#anovenc2#'>
<cfset vencimento2df = dateformat(vencformat2)>
<cfset atraso2 = DateDiff("d", vencimento2df, hoje)> 
<cfif atraso2 le 0>
	<cfset atraso2 =0>
</cfif>



<cfif DayOfWeek(hoje) eq 2 AND ( atraso2 eq 1 or atraso2 eq 2)>
<cfset atraso2 =0>
</cfif>
<!--- somente para feriado de 12 outubro de 2015 
<cfif DayOfWeek(hoje) eq 3 AND ( atraso2 eq 1 or atraso2 eq 2 or atraso2 eq 3)>
<cfset atraso2 =0>
</cfif>--->


<cfset mes2=#mes#>
<cfoutput> </cfoutput>
<cfquery datasource="mls_dbwireless02" name="lista2" >
select #mes2#.username, cod, codcli, endereco, nnumero, nbanco, cobranca, bairro, cep, #mes2#.valor, pago from #mes2#, cobra1 
where cod = #cod# and cod=codcli and pago = 'False'
</cfquery>


<cfset mc = mm-3>
<cfif mc LTE 0>
	<cfset mc = 12+mm-3>
</cfif>
<cfif mm lt 4>
	<cfset ano = ano_corrente -1>
<cfelse>
	<cfset ano = ano_corrente>	
</cfif>


<cfif verifica.cobranca is 'W' and  "I,D,DR,WI,W" contains verifica.cobranca_old>
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento[mc]>
	<cfset diavenc3 = mid(vencimento[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento[mc],4,2)>
	<cfset anovenc3 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'W' and  "S0,S1,S2,S4" contains verifica.cobranca_old> <!--- trocar para c_ em final de dezembro --->
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento[mc]>
	<cfset diavenc3 = mid(vencimento[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento[mc],4,2)>
	<cfset anovenc3 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'W' and verifica.cobranca_old is 'M'><!--- trocar para c_ em final de dezembro --->
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento20[mc]>
	<cfset diavenc3 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento20[mc],4,2)>
	<cfset anovenc3 = mid(vencimento20[mc],7,2)>	
<cfelseif verifica.cobranca is 'I' or verifica.cobranca is 'D' or verifica.cobranca is 'DR' or verifica.cobranca is 'WI'>
	<cfset mes= 'i_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento[mc]>
	<cfset diavenc3 = mid(vencimento[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento[mc],4,2)>
	<cfset anovenc3 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'S0' or verifica.cobranca is 'S1' or verifica.cobranca is 'S2' or verifica.cobranca is 'S4'>
	<cfset mes= 'c_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento[mc]>
	<cfset diavenc3 = mid(vencimento[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento[mc],4,2)>
	<cfset anovenc3 = mid(vencimento[mc],7,2)>
<cfelseif verifica.cobranca is 'M'>
	<cfset mes= 'h_'&'#calcmes[mc]#'&'#ano#'>
	<cfset vencimento3 = vencimento20[mc]>
	<cfset diavenc3 = mid(vencimento20[mc],1,2)>
	<cfset mesvenc3 = mid(vencimento20[mc],4,2)>
	<cfset anovenc3 = mid(vencimento20[mc],7,2)>
</cfif>
<cfset vencformat3 = '#mesvenc3#'&'/'&'#diavenc3#'&'/'&'#anovenc3#'>
<cfset vencimento3df = dateformat(vencformat3)>
<cfset atraso3 = DateDiff("d", vencimento3df, hoje)> 
<cfif atraso3 le 0>
	<cfset atraso3 =0>
</cfif>



<cfif DayOfWeek(hoje) eq 2 AND ( atraso3 eq 1 or atraso3 eq 2)>
<cfset atraso3 =0>
</cfif>
<!--- somente para feriado de 12 outubro de 2015 
<cfif DayOfWeek(hoje) eq 3 AND ( atraso3 eq 1 or atraso3 eq 2 or atraso3 eq 3)>
<cfset atraso3 =0>
</cfif>--->


<cfoutput> </cfoutput>

<cfset mes3=#mes#>

<cfquery datasource="mls_dbwireless02" name="lista3" >
select #mes3#.username, cod, codcli, endereco, nnumero, nbanco, cobranca, bairro, cep, #mes3#.valor, pago from #mes3#, cobra1 
where cod = #cod# and cod=codcli and pago = 'False'
</cfquery>



<cfoutput>
#verifica.nome#
<cfif  #mid(CGI.REMOTE_ADDR,1,10)# is '200.152.96'>
 - mes corrente #mm# -  meses pesquisados para boletos #mes1#,#mes2#,#mes3#
</cfif>

</cfoutput>

<br>
<bR>

										<cfif verifica.recordcount lte 0>
										<div class="alert-box warning">Usu&aacute;rio n&atilde;o encontrado</div>
										<br>
										</cfif>

		   			<!-- INICIO DA LISTA DE BOLETOS -->
                  <table width="100%" >
                        
							<cfoutput query="lista">
							<cfset aberto = 1>


							<cfif atraso1 gt 0 >
								<cfset valorcorrigido1 =numberformat(valor*(1.02 + atraso1*0.01/30),"99999.99")>
							<cfelse>
								<cfset valorcorrigido1 =numberformat(valor,"99999.99")>
							</cfif>


							<form method="post" action="../boleto/boleto_online.php" target="_blank">
							<input type="hidden" name="nome" value="#verifica.nome#">
							<input type="hidden" name="endereco" value="#endereco#">
							<cfif atraso1 gt 0>
								<input type="hidden" name="valor" value="#trim(valor)#"><!--- era valorcorrigido1 e passou para valor em out18 pois os banco fazem o calculo --->
								<input type="hidden" name="vencimento" value="#vencimento1#"> <!--- Era novovencimento  e passou para vencimento1 em out18---> 
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
                            <td width="30%" align="left" class="texto-cinza-quadro">Nome:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#verifica.nome#</td>
					        </tr>
							<tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Valor:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#numberformat(valor,"9999.99")#</td>
                            <td width="13%"  align="left" valign="top"></td>
							</tr>
							<tr>			
			    <td width="30%" align="left" class="texto-cinza-quadro">Vencimento:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#vencimento1#</td>
			    <td width="13%" align="left" valign="top"></td>
                           	</tr>
							<cfif atraso1 gt 0>
							<!---tr>  Retirado em out18 para não mostrar a possível diferença pelo calculo do banco
                            <td width="30%" align="left" class="texto-vermelho-quadro"><b>Valor Corrigido Aproximado:</b></td>
			    <td width="50%" align="left" class="texto-vermelho-quadro" valign="top"><b>#valorcorrigido1#</b></td>
			    <td width="13%" align="left" valign="top"></td>
							</tr>
							<tr>
			    <td width="30%" align="left" class="texto-vermelho-quadro"><b>Novo Vencimento:</b></td>
                            <td width="50%" align="left" class="texto-vermelho-quadro" valign="top"><b>#novovencimento#</b></td>
			    <td width="13%" align="left" valign="top"></td>
                            </tr--->
							<tr>
			    <td width="30%" align="left" class="texto-cinza-quadro"><b>Atraso:</b></td>
                            <td width="50%" align="left" class="texto-cinza-quadro valign="top"><b>#atraso1# dias</b></td>
			    <td width="13%" align="left" valign="top"></td>
                           	</tr>
							</cfif>
                            <tr>
			    <td width="30%" align="left" class="texto-cinza-quadro">Documento:</td>
			    			<td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nnumero#</td>
                            <td width="13%" align="left" valign="top"></td>
                           	</tr>
                            <tr>
			    <td width="30%" align="left" class="texto-cinza-quadro">Referente:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#mes1#</td>
			    <td width="13%" align="left" valign="top"></td>
                           	</tr>
                            <tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Boleto:</td>
                            <!--- nbanco só para a bradesco , HSBC não tem nbanco --->
                            <cfif len(nbanco) gt 3 or verifica.cobranca is 'S0' or verifica.cobranca is 'S1' or verifica.cobranca is 'S2' or verifica.cobranca is 'S4' or verifica.cobranca is 'M'>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nbanco#</td>
                            <td width="23%" align="left" class="texto-cinza-quadro" valign="top"><input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" >
                            <cfelse>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">Aguardando confirmação do Banco</td>
			    			</cfif>
                            
						    </td>
							</form>
							</tr>
							
	                        </cfoutput>	
	                 							
							
	                        <cfoutput query="lista2">
							<cfset aberto = 1>
							<cfset valorcorrigido2=numberformat(valor*(1.02+atraso2*0.01/30),"99999.99")>
	
					<!---   alterado para imprimir boleto CEDENTE corretamente     nova_cobranca--->
							<form method="post" action="../boleto/boleto_online.php?" target="_blank">
							<input type="hidden" name="nome" value="#verifica.nome#">
							<input type="hidden" name="endereco" value="#endereco#">
							<cfif atraso2 gt 0>
								<input type="hidden" name="valor" value="#trim(valor)#"> <!--- era valorcorrigido2 e passou para valor em out18 pois os banco fazem o calculo --->
								<input type="hidden" name="vencimento" value="#vencimento2#"><!--- Era novovencimento  e passou para vencimento1 em out18---> 
							<cfelse>
								<input type="hidden" name="valor" value="#valor#">
								<input type="hidden" name="vencimento" value="#vencimento2#">
							</cfif>
							<input type="hidden" name="nbanco" value="#nbanco#">
							<input type="hidden" name="nnumero" value="#nnumero#">
					<!---   alterado para imprimir boleto CEDENTE corretamente   nova_cobranca --->
							
															
							<input type="hidden" name="cobranca" value="#verifica.cobranca#">
						
                          	<tr>

			<td height="20" colspan="4"><hr></td></tr>

                            <td width="30%" align="left" class="texto-cinza-quadro">Nome:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro valign="top">#verifica.nome#</td>
			   <td width="23%" align="left" valign="top"></td>
					        </tr>
							<tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Valor:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#numberformat(valor,"9999.99")#</td>
                            <td width="23%" align="left" valign="top"></td>
							</tr>
							<tr>
			    <td width="30%" align="left" class="texto-cinza-quadro">Vencimento:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#vencimento2#</td>
			    <td width="23%" align="left" valign="top"></td>
                            </tr>
							<cfif atraso2 gt 0>
							<!---tr>
                            <td width="30%" align="left" class="texto-vermelho-quadro"><b>Valor Corrigido Aproximado:</b></td>
			    <td width="50%" align="left" class="texto-vermelho-quadro" valign="top"><b>#valorcorrigido2#</b></td>
			    <td width="23%" align="left" valign="top"></td>
							</tr>
							<tr>
			    <td width="30%" align="left" class="texto-vermelho-quadro"><b>Novo Vencimento:</b></td>
                            <td width="50%" align="left" class="texto-vermelho-quadro" valign="top"><b>#novovencimento#</b></td>
			    <td width="23%" align="left" valign="top"></td>
                            </tr--->
							<tr>
			    			<td width="30%" align="left" class="texto-cinza-quadro"><b>Atraso:</b></td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top"><b>#atraso2# dias</b></td>
			   				 <td width="23%" align="left" valign="top"></td>
                           	</tr>
							</cfif>
                            <tr>
			    <td width="30%" align="left" class="texto-cinza-quadro">Documento:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nnumero#</td>
			    <td width="23%" align="left" valign="top"></td>
                           	</tr>
                             <tr>
			    <td width="30%" align="left" class="texto-cinza-quadro">Referente:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#mes2#</td>
			    <td width="23%" align="left" valign="top"></td>
                           	</tr>
                            <tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Boleto:</td>
                            <!--- nbanco só para a bradesco , HSBC não tem nbanco --->
                            <!--- coloquei o _old para aquivos antigos h_  retirar em novembro--->
                            <cfif len(nbanco) gt 1 or verifica.cobranca_old is 'S0' or verifica.cobranca_old is 'S1' or verifica.cobranca_old is 'S2' or verifica.cobranca_old is 'S4' or verifica.cobranca_old is 'M'>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nbanco#</td>
                            <td width="23%" align="left" class="texto-cinza-quadro" valign="top"><input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" >
                            <cfelse>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">Aguardando confirmação do Banco</td>
			    			</cfif>
							</td>
							</form>
							</tr>
							
	                        </cfoutput>	
							<td height="20" colspan="4"><hr></td></tr>
                       
                     
                            
							<cfoutput query="lista3">
							<cfset aberto = 1>
							<cfset valorcorrigido3 =numberformat(valor*(1.02 + atraso3*0.01/30),"99999.99")>
							<form method="post" action="../boleto/boleto_online.php?" target="_blank">
							<input type="hidden" name="nome" value="#verifica.nome#">
							<input type="hidden" name="endereco" value="#endereco#">
							<cfif atraso3 gt 0>
								<input type="hidden" name="valor" value="#trim(valor)#"><!--- era valorcorrigido3 e passou para valor em out18 pois os banco fazem o calculo --->
								<input type="hidden" name="vencimento" value="#vencimento3#"><!--- Era novovencimento  e passou para vencimento3 em out18---> 
							<cfelse>
								<input type="hidden" name="valor" value="#valor#">
								<input type="hidden" name="vencimento" value="#vencimento3#">
							</cfif>
							<input type="hidden" name="nbanco" value="#nbanco#">
							<input type="hidden" name="nnumero" value="#nnumero#">
							
							
							<input type="hidden" name="cobranca" value="#verifica.cobranca#">
							
							
                          	<tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Nome:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#verifica.nome#</td>
                            <td width="23%" align="left" valign="top"></td>
					        </tr>
							<tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Valor:</td>
                            <td width="48%" align="left" class="texto-cinza-quadro"valign="top">#numberformat(valor,"99999.99")#</td>
                            <td width="23%" align="left" valign="top"></td>
							</tr>
							<tr>
							<td width="30%" align="left" class="texto-cinza-quadro">Vencimento:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#vencimento3#</td>
                            <td width="23%" align="left" valign="top"></td>
                            </tr>
							<cfif atraso3 gt 0>
							<!---tr>
                            <td width="30%" align="left" class="texto-vermelho-quadro"><b>Valor Corrigido Aproximado:</b></td>
							<td width="50%" align="left" class="texto-vermelho-quadro" valign="top">#valorcorrigido3#</td>
							<td width="23%" align="left" valign="top"></td>
							</tr>
							<tr>
							<td width="30%" align="left" class="texto-vermelho-quadro"><b>Novo Vencimento:</b></td>
                            <td width="50%" align="left" class="texto-vermelho-quadro" valign="top">#novovencimento#</td>
                            <td width="23%" align="left" valign="top"></td>
                            </tr--->
							<tr>
							<td width="30%" align="left" class="texto-cinza-quadro"><b>Atraso:</b></td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#atraso3# dias</td>
                            <td width="23%" align="left" valign="top"></td>
                           	</tr>
							</cfif>
							<tr>
							<td width="30%" align="left" class="texto-cinza-quadro">Documento:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nnumero#</td>
                            <td width="23%" align="left" valign="top"></td>
                           	</tr>
                            <tr>
							<td width="30%" align="left" class="texto-cinza-quadro">Referente:</td>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#mes3#</td>
                            <td width="23%" align="left" valign="top"></td>
                           	</tr>
                           	
                            <tr>
                            <td width="30%" align="left" class="texto-cinza-quadro">Boleto:</td>
                            <!--- nbanco só para a bradesco , HSBC não tem nbanco --->
                             <!--- coloquei o _old para aquivos antigos h_  retirar em dezembro--->
                            <cfif len(nbanco) gt 1 or verifica.cobranca_old is 'S0' or verifica.cobranca_old is 'S1' or verifica.cobranca_old is 'S2' or verifica.cobranca_old is 'S4' or verifica.cobranca_old is 'M'>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">#nbanco#</td>
                            <td width="23%" align="left" class="texto-cinza-quadro" valign="top"><input type="submit" name="loginButton" tabindex="22" value="EMITIR" class="form-button" >
                            <cfelse>
                            <td width="50%" align="left" class="texto-cinza-quadro" valign="top">Aguardando confirmação do Banco</td>
			    			</cfif>
			    			
			    			</td>
							</form>
							</tr>
							
	                        </cfoutput>	
							 </table>
	                  
	                  <!-- FINAL DA LISTA DE BOLETOS -->
							<br>
							
							<!-- INICIO DA LISTA DE NOTAS -->
							<table width="100%">
							
                       <tr>
									<td colspan="4" class="texto-cinza-quadro">
											<strong class="titulo-azul-quadro">Notas Fiscais Emitidas</strong>
									</td>
                       </tr>
                            <cfloop query="notas">
                      	<tr>
	      						<td width="30%" align="left" class="texto-cinza-quadro">Nota  <cfoutput>#dateformat(emissao, "dd/mm/yyyy")#</cfoutput>:</td>
                           <td width="50%" align="left" class="texto-cinza-quadro" valign="top">
							<cfoutput> <a href="https://notacarioca.rio.gov.br/contribuinte/notaprint.aspx?inscricao=2721775&nf=#nota#&verificacao=#verificacao#"> #nota#</a></cfoutput></td>
                     	</tr>
                            </cfloop>   
                        </table>
                        
                        <!-- FINAL DA LISTA DE NOTAS -->
                        <!-- <cfoutput>#mes1# - #mes2# - #mes3# - #mm#</cfoutput> -->
                  
                
                  
<cfelse>
Erro!  - Dados incorretos<br><br><br><br><br><br><br><abort>
</cfif>

