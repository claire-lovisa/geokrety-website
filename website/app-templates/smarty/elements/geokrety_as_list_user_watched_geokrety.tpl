<tr class="{if $geokret->missing}danger{/if}">
    <td>
        {$geokret|posicon nofilter}
    </td>
    <td>
        {$geokret|gklink nofilter} {$geokret|gkavatar nofilter}<br />
        <small>{$geokret->gkid}</small>
    </td>
    <td class="text-center">
        {$geokret->owner|userlink:'' nofilter}
    </td>
    <td class="text-center">
        {if !is_null($geokret->last_position)}
        {$geokret->last_position->country|country nofilter}
        {$geokret->last_position|cachelink nofilter}
        {/if}
    </td>
    <td class="text-center" nowrap>
        {if !is_null($geokret->last_position)}
        {$geokret->last_position|logicon:true nofilter}
        {$geokret->last_position->moved_on_datetime|print_date nofilter}
        <br />
        <small>{$geokret->last_position->author|userlink:$geokret->last_position->username nofilter}</small>
        {else}
        {$geokret->created_on_datetime|print_date nofilter}
        {/if}
    </td>
    <td class="text-right">
        {$geokret->distance} km
    </td>
    <td class="text-right">
        {$geokret->caches_count}
    </td>
    <td class="text-right">
        {if $geokret->isHolder()}
        <a class="btn btn-default btn-xs" href="#" title="{t}Move this GeoKret{/t}">🛩️</a>
        {/if}
    </td>
</tr>
