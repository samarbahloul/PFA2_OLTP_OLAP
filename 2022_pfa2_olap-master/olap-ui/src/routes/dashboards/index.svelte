<script>
	import axios from 'axios';
    import { onMount } from 'svelte';

	let dashboards=[]

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
	
</script>

<table>
    <tr><th>idDashboar</th><th>title</th><th>voir</th></tr>
    {#each dashboards as d}
        <tr><td>{d.idDashboard}</td><td>{d.title}</td><td><a href="dashboards/{d.idDashboard}">voir</a></td></tr>
    {/each}
</table>