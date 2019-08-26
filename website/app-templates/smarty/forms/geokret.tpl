<div class="panel panel-default">
    <div class="panel-heading">
        {if $geokret->id}
        <h3 class="panel-title">{t}Edit a GeoKret{/t}</h3>
        {else}
        <h3 class="panel-title">{t}Create a new GeoKret{/t}</h3>
        {/if}
    </div>
    <div class="panel-body">


        <form class="form-horizontal" method="post" data-parsley-validate data-parsley-priority-enabled=false data-parsley-ui-enabled=true>
            <div class="form-group">
                <label for="inputName" class="col-sm-2 control-label">{t}GeoKret name{/t}</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control maxl" id="inputName" name="name" placeholder="{t}GeoKret name{/t}" minlength="{GK_GEOKRET_NAME_MIN_LENGTH}" maxlength="{GK_GEOKRET_NAME_MAX_LENGTH}" required value="{$geokret->name}">
                </div>
            </div>

            <div class="form-group">
                <label for="inputGeokretType" class="col-sm-2 control-label">{t}GeoKret type{/t}</label>
                <div class="col-sm-10">
                    <select class="form-control" id="inputGeokretType" name="type">
                        {foreach \GeoKrety\GeokretyType::getTypes() as $key => $gktype}
                        <option value="{$key}" {if isset($geokret) && $geokret->type->isType($key)} selected{/if} required>{$gktype}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="inputMission" class="col-sm-2 control-label">{t}Mission{/t}</label>
                <div class="col-sm-10">
                    <textarea class="form-control maxl" rows="5" id="inputMission" name="mission" placeholder="{t}What is this GeoKrety mission?{/t}" maxlength="5120">{$geokret->mission}</textarea>
                </div>
            </div>

            {*if $isCreate and $user->hasCoordinates()}
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="logAtHome" name="log_at_home"> {t}Set my home coordinates as a starting point.{/t}
                        </label>
                    </div>
                </div>
            </div>
            {/if*}

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">{if $geokret->id}{t}Save{/t}{else}{t}Create{/t}{/if}</button>
                </div>
            </div>

        </form>
    </div>
</div>
