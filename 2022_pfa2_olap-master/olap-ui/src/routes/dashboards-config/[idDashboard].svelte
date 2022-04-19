<script>
	import axios from 'axios';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';

	let dashboard = {};
	let newGraph = {
		"type": "",
		"title": "",
		"xaxisTitle": "",
		"yaxisTitle": "",
		"sqlQuery": "",
		"idDatasourceDefinition": null
	};

	let getDashboard = (idDashboard) => {
		axios
			.get('http://localhost:8080/dashboards/' + idDashboard)
			.then(function (response) {
				console.log(response);
				dashboard = response.data;
			})
			.catch(function (error) {
				console.log(error);
			});
	}
    let addGraph = () => {
		axios
			.post('http://localhost:8080/dashboards/'+dashboard.idDashboard, newGraph)
			.then(function (response) {
				getDashboard(dashboard.idDashboard);
			})
			.catch(function (error) {
				console.log(error);
			});
	};

	onMount(async () => {
		let idDashboard = $page.params.idDashboard;
		getDashboard(idDashboard);
	});
</script>

id : {dashboard.idDashboard}
title : {dashboard.title}
{#if dashboard.graphs}
	<table>
		<tr><th>idGraph</th><th>title</th><th>xaxisTitle</th><th>yaxisTitle</th><th>sql</th><th>datasourceID</th></tr>
		{#each dashboard.graphs as g}
			<tr><td>{g.idGraph}</td><td>{g.title}</td><td>{g.xaxisTitle}</td><td>{g.yaxisTitle}</td><td>{g.sqlQuery}</td><td>{g.datasource.id}</td></tr>
		{/each}
	</table>
{/if}
<br/>
Add graph to dashboard {dashboard.idDashboard}
<form>
	type : <input type="text" bind:value={newGraph.type} /><br/>
	title : <input type="text" bind:value={newGraph.title} /><br/>
	xaxisTitle : <input type="text" bind:value={newGraph.xaxisTitle} /><br/>
	yaxisTitle : <input type="text" bind:value={newGraph.yaxisTitle} /><br/>
	idDatasourceDefinition : <input type="text" bind:value={newGraph.idDatasourceDefinition} /><br/>
	sqlQuery : <input type="text" bind:value={newGraph.sqlQuery} /><br/>
	<button type="submit" on:click|preventDefault={addGraph}>Add graph</button>
</form>
