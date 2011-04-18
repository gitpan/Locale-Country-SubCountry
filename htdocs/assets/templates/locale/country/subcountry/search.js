// search.js.

function prepare_search_form()
{
	YUI().use
	(
		"datatable", "gallery-formmgr", "io-base", "io-form", "json", "node", function(Y)
		{
			var f = new Y.FormManager("search_form",
			  {
			  });

			f.prepareForm();

			var success_fn = function(ioId, o)
			{
				if (o.responseText !== undefined)
				{
					try
					{
						var data = Y.JSON.parse(o.responseText);
						var cols =
							[
								{key: "id",   label: "Id"},
								{key: "name", label: "Name"}
							];
						div.set("innerHTML", "");
						var table = new Y.DataTable.Base
						({
							columnset: cols,
							recordset: data.results
						}).render("#search_result_div");
					}
					catch(e)
					{
						alert("The server's reply is not in JSON format");
					}
				}
				else
				{
					div.set("innerHTML", "The server's response is incomprehensible");
				}
			};
			var failure_fn = function(ioId, o)
			{
				div.set("innerHTML", "The server failed to respond");
			};

			Y.on("click", function()
			 {
				 f.populateForm();
			 }, "#reset_search");
			Y.on("click", function()
			 {
				 if (FIC_checkForm("search_form") == false)
				 {
					 return false;
				 }

				 var cfg =
					 {
						 form:
						 {
							 id: "search_form"
						 },
						 method: "POST",
						 on:
						 {
							 success: success_fn,
							 failure: failure_fn
						 },
						 sync: true
					 };
				 var request = Y.io("/search", cfg);
			 }, "#submit_search");

			var div = Y.one("#search_result_div");
		}
	);
}
