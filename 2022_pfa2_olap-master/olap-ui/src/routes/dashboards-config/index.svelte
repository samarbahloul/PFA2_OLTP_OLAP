<script>
	import axios from 'axios';
    import { onMount } from 'svelte';

	let dashboards=[]

    let newDashboard = {
		"title": ""
	};

	onMount(async () => {
		getDashboards();
	});


    let getDashboards = () => {
        axios
			.get('http://localhost:8080/dashboards')
			.then(function (response) {
                dashboards = response.data
			})
			.catch(function (error) {
				console.log(error);
			});
    }
	let addDashboard = () => {
		axios
			.post('http://localhost:8080/dashboards', newDashboard)
			.then(function (response) {
                newDashboard.title="";
				getDashboards();
			})
			.catch(function (error) {
				console.log(error);
			});
	}
</script>

Add dashboard
<form>
	title : <input type="text" bind:value={newDashboard.title} />
	<button type="submit" on:click|preventDefault={addDashboard} >Add dashboard</button>
</form>

<table>
    <tr><th>idDashboar</th><th>title</th><th>voir</th></tr>
    {#each dashboards as d}
        <tr><td>{d.idDashboard}</td><td>{d.title}</td><td><a href="dashboards-config/{d.idDashboard}">voir</a></td></tr>
    {/each}
</table>