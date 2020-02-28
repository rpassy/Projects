
<cfinclude  template="header.cfm"> 


<div class="row">
   <div class="medium-9 medium-push-3 columns">
   <cfinclude  template="menu.php">
   </div>
   <!--Close medium-9--> 
</div>
<div class="row">
      
         <div class="medium-3 columns">

         &nbsp;
         </div>
      
         
         <div class="medium-9 columns collapse">
         
         <h1>Emissão de 2 via de Boleto Bancário</h1>
         

             <cfform name="login" action="2via-lista.cfm" method="post" target="_parent">

                    <div class="row">
         <div class="form-style" id="segunda_via_form">
            <div class="medium-6 columns">
               <label>Nome*
		<cfinput type="text" tabindex="1" size="45" name="nome" value="" required="Yes" message="Voce precisa especificar o nome">
		 </label>

						
     <label>Código*
      <input type="password" tabindex="2" name="cod" size="10" required  oninvalid="this.setCustomValidity('Entre com o seu código')" oninput="setCustomValidity('')">
      </label>
								
      <label>CPF/CNPJ*
        <input type="password" tabindex="2" name="CGC" size="18" required oninvalid="this.setCustomValidity('Voce precisa especificar seu CPF / CNPJ')" oninput="setCustomValidity('')">&nbsp; (somente os algarismos)
</label>
                <input type="submit" class="button" name="loginButton" tabindex="4" value="Emitir"></td>
							<td></td>	
                          </tr>
                        
                            <tr align="right">
                          <td align="left"  colspan="3" class="texto-cinza-quadro" >
                            <hr width="400">
                            
                            <br>
                            <strong class="titulo-azul-quadro">&nbsp;&nbsp;<br>
			                 Confira os campos abaixo<br>
							</strong>
         			        

 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="445" height="330">
              <param name="movie" value="../../boleto/imagens/help-boleto.swf">
              <param name="quality" value="high">
              <embed src="../boleto/imagens/help-boleto.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="350" height="300"></embed>
            </object>


         			        
</td>
                          </tr>
                        </table>
                        <strong class="titulo-azul-quadro"><br><br>
                        
                        </strong></td>
          </cfform>
           </div>
         </div>
      </div>
     

</div>
</div>
<cfinclude template="footer.php" >
<script src="js/validador.js"></script>
</body>
</html>

