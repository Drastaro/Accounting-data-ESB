<div class="section-header">
    <div class="container">
        <h1 class="page-header">{if $secu->isSignup()}Activare cont{else}Resetare parolă{/if}</h1>
    </div>
</div>

<div class="container">

    <br>
    {if $messages}
        {$messages}<br>
    {else}
        <p>
            Alegeți o {if $secu->isRecovery()}nouă{/if} parolă.
            Parola {if $secu->isRecovery()}nouă{/if} trebuie să aibă minim 6 caractere.
        </p>
    {/if}

    <div class="row">

        <div class="col-md-7">
            <form method="POST" action="">
                <input type="hidden" name="mode" value="login">

                <div class="form-group">
                    <label for="p1">Parola {if $secu->isRecovery()}nouă{/if}</label>
                    <input type="password" id="p1" name="p1" class="form-control" placeholder="Introduceți {if $secu->isRecovery()}noua parolă{else}parola{/if}">
                </div>

                <div class="form-group">
                    <label for="p2">Confirmare parolă</label>
                    <input type="password" id="p2" name="p2" class="form-control" placeholder="Reintroduceți {if $secu->isRecovery()}noua parolă{else}parola{/if}">
                </div>

                <div class="form-group clearfix">
                    <button type="submit" class="btn btn-primary pull-right">Efectuați</button>
                </div>
                <br><br>

            </form>

            <script type="text/javascript">
                document.getElementById('p1').focus();
            </script>

        </div>
    </div>

</div>