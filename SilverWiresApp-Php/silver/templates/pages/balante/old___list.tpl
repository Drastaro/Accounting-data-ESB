<div class="page-header">
    <h1>Balante companie {$company->name}</h1>
</div>


<table class="table table-striped table-hover ">
    <thead>
        <tr>
            <th>An balanta</th>
            <th>Luna balanta</th>
            <th>Data adaugarii</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=c from=$balante name=bList}
        <tr>
            <td>{$c->an}</td>
            <td>{$c->luna}</td>
            <td></td>
        </tr>
        {/foreach}
    </tbody>
</table>



<div class="page-header">
    <h2>Adauga o balanta</h2>
</div>
<!-- Login form -->
<form class="form-horizontal" method="post" enctype="multipart/form-data" action="/balante">
    <input type="hidden" name="mode" value="add-balanta">
    <input type="hidden" name="companyId" value="{$company->id}">
    <fieldset>

        <div class="form-group">
            <label for="inputAn" class="col-md-2 control-label">An</label>
            <div class="col-md-4">
                <select class="form-control" id="inputAn" name="an">
                    <option value="2013">2013</option>
                    <option value="2014" selected>2014</option>
                    <option value="2015">2015</option>
                </select>
            </div>
            <label for="inputLuna" class="col-md-2 control-label">Luna</label>
            <div class="col-md-4">
                <select class="form-control" id="inputLuna" name="luna">
                    <option value="1">Ianuarie</option>
                    <option value="2">Februarie</option>
                    <option value="3">Martie</option>
                    <option value="4">Aprilie</option>
                    <option value="5">Mai</option>
                    <option value="6">Iunie</option>
                    <option value="7">Iulie</option>
                    <option value="8">August</option>
                    <option value="9">Septembrie</option>
                    <option value="10">Octombrie</option>
                    <option value="11">Noiembrie</option>
                    <option value="12">Decembrie</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="inputFisier" class="col-md-2 control-label">Nume companie</label>
            <div class="col-md-10">
                <input class="form-control" id="inputFisier" name="fisier" placeholder="Selecteaza fisier" type="file">
            </div>
        </div>


        <div class="form-group">
            <div class="col-md-10 col-md-offset-2">
                <button type="submit" class="btn btn-primary">Adaugă</button>
            </div>
        </div>

    </fieldset>
</form>
