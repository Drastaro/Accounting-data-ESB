<div class="page-header">
    <h1>Companii</h1>
</div>

{if $companii}
<table class="table table-striped table-hover ">
    <thead>
        <tr>
            <th>#</th>
            <th>Nume Companie</th>
            <th>Balante</th>
            <th>Opțiuni</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=c from=$companii name=cList}
        <tr>
            <td>{$smarty.foreach.cList.iteration}</td>
            <td>{$c->name}</td>
            <td>
                <a href="/balante?cid={$c->id}" class="btn btn-primary">Balante incarcate</button>
            </td>
            <td></td>
        </tr>
        {/foreach}
    </tbody>
</table>
{/if}


<div class="page-header">
    <h2>Adaugă o companie</h2>
</div>
<!-- Login form -->
<form class="form-horizontal" method="post">
    <input type="hidden" name="mode" value="add-companie">
    <fieldset>

        <div class="form-group">
            <label for="inputNume" class="col-md-2 control-label">Nume companie</label>
            <div class="col-md-10">
                <input class="form-control" id="inputNume" name="name" placeholder="Numele complet" type="text">
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-10 col-md-offset-2">
                <button type="submit" class="btn btn-primary">Adaugă</button>
            </div>
        </div>

    </fieldset>
</form>
