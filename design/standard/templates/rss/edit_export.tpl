<form action={"rss/edit_export"|ezurl} method="post" name="RSSExport">

<table class="layout" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td valign="top">
    <!-- Main part start -->
    <div class="maincontentheader">
    <h1>{"RSS Export"|i18n("design/standard/rss/edit")}</h1>
    </div>

    <div class="block">
    
    <label>{"Title"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    {include uri="design:gui/lineedit.tpl" id_name=title value=$rss_export.title|wash}
    <br/>
    <label>{"Description"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    <textarea name="Description" cols="64" rows="3">{$rss_export.description|wash}</textarea>
    <br/>
    <label>{"Site URL"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    {include uri="design:gui/lineedit.tpl" id_name=url value=$rss_export.url}
    <br/>

    <input type="hidden" name="RSSImageID" value="{$rss_export.image_id}" />
    <label>{"Image"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    <input type="text" readonly="readonly" size="45" value="{$rss_export.image_path|wash}" maxlength="50" />
    {include uri="design:gui/button.tpl" id_name="BrowseImageButton" value="Browse"|i18n("design/standard/rss/edit")}
    <br/>


    <label>{"Site Access"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    <select name="SiteAccess">

    {section name=SiteAccess loop=$rss_site_access }
    <option
    {section name=Access show=eq($:item,$rss_export.site_access)}
      selected="selected"
    {/section} value="{$:item}">{$:item|wash}</option>
    {/section}
    </select>

    <br/>

    <label>{"RSS version"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>

    <select name="RSSVersion">
    {section name=Version loop=$rss_version_array}
    <option
    {section name=DefaultSet show=eq($rss_export.rss_version,0)}
      {section name=Default show=eq($Version:item,$rss_version_default)}
        selected="selected"
      {/section}
    {section-else}
      {section name=Default2 show=eq($Version:item,$rss_export.rss_version)}
        selected="selected"
      {/section}
    {/section}
      value="{$:item}">{$:item|wash}
    </option>
    {/section}
    </select>

    <br/>

    <label>{"Active"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    <input type="checkbox" name="active" {section show=$rss_export.active|eq(1)}checked="checked"{/section}>{"Active"|i18n("design/standard/rss/edit")}</input>
    <br/>
    <label>{"Access URL"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
    rss/feed/ {include uri="design:gui/lineedit.tpl" id_name="Access_URL" value=$rss_export.access_url}
    <br/>
    
    </div>

    <input type="hidden" name="RSSExport_ID" value={$rss_export.id} />
    <input type="hidden" name="Item_Count" value={count($rss_export.item_list)} />

    {section name=Source loop=$rss_export.item_list}

       <h2>Source {sum($Source:index, 1)}</h2>

       <input type="hidden" name="Item_ID_{$Source:index}" value="{$Source:item.id}" />
       <label>{"Source path"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
       <input type="text" readonly="readonly" size="45" value="{$Source:item.source_path|wash}" maxlength="60" />
       {include uri="design:gui/button.tpl" id_name=concat( "SourceBrowse_", $Source:index ) value="Browse"|i18n("design/standard/rss/edit")}
       <br/>

       <label>{"Class"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
       <select name="Item_Class_{$Source:index}">
       {section name=ContentClass loop=$rss_class_array }
       <option
       {section name=Class show=eq($:item.id,$Source:item.class_id)}
         selected="selected"
       {/section} value="{$:item.id}">{$:item.name|wash}</option>
       {/section}
       </select>
       {include uri="design:gui/button.tpl" id_name="Update_Item_Class" value="Update"|i18n("design/standard/rss/edit")}
       <br/>
              
       {section name=Attribute show=count($rss_export.item_list[$Source:index])|gt(0)}

         <label>{"Title"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
         <select name="Item_Class_Attribute_Title_{$Source:index}">
         {section name=ClassAttribute loop=$rss_export.item_list[$Source:index].class_attributes}
         <option value="{$:item.identifier}" 
             {section name=ShowSelected show=eq($Source:item.title,$:item.identifier)}
                 selected="selected"
             {/section}>{$:item.name|wash}</option>
         {/section}
         </select>
	 <br/>

         <label>{"Description"|i18n("design/standard/rss/edit")}:</label><div class="labelbreak"></div>
         <select name="Item_Class_Attribute_Description_{$Source:index}">
         {section name=ClassAttribute loop=$rss_export.item_list[$Source:index].class_attributes}
         <option value="{$:item.identifier|wash}" 
             {section name=ShowSelected show=eq($Source:item.description,$:item.identifier)}
                 selected="selected"
             {/section}>{$:item.name|wash}</option>
         {/section}
         </select>
	 <br/>

       {/section}

    {/section}

    <div class="buttonblock">
    <input class="defaultbutton" type="submit" name="StoreButton" value="{'Store'|i18n('design/standard/rss/edit')}" />
    <input class="button" type="submit" name="AddSourceButton" value="{'Add Source'|i18n('design/standard/rss/edit')}" />
    <input class="button" type="submit" name="RemoveButton" value="{'Remove'|i18n('design/standard/rss/edit')}" />
    </div>
    <!-- Main part end -->
    </td>
</tr>
</table>
</form>


