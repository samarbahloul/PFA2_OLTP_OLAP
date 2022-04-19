<script>
	import axios from 'axios';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import 'charts.css';
	import Bar from 'svelte-chartjs/src/Bar.svelte';
	import Pie from 'svelte-chartjs/src/Pie.svelte';

	let dashboard = {};
	let options = { responsive: true };
	const COLORS = [
  '#4dc9f6',
  '#f67019',
  '#f53794',
  '#537bc4',
  '#acc236',
  '#166a8f',
  '#00a950',
  '#58595b',
  '#8549ba'
];
	let getDashboardData = (idDashboard) => {
		axios
			.get('http://localhost:8080/dashboards/' + idDashboard + '/data')
			.then(function (response) {
				dashboard = response.data;
			})
			.catch(function (error) {
				console.log(error);
			});
	};

	onMount(async () => {
		let idDashboard = $page.params.idDashboard;
		getDashboardData(idDashboard);
	});
</script>

<h1>using charts.css</h1>
id : {dashboard.id}
title : {dashboard.title}
{#if dashboard.graphs}
	{#each dashboard.graphs as g}
		<table class="charts-css {g.type} show-labels">
			<caption> {g.title}</caption>
			<thead><tr><th scope="col">{g.xaxisTitle} </th><th scope="col">{g.yaxisTitle}</th></tr></thead>
			<tbody>
				{#each g.data[g.xaxisTitle] as valX, index}
					<tr>
						<th scope="row"> {valX} </th>
						<td style="--size: calc( {g.data[g.yaxisTitle][index]}/max({g.data[g.yaxisTitle]}))">
							{g.data[g.yaxisTitle][index]}
						</td>
					</tr>
				{/each}
			</tbody>
		</table>
	{/each}
{/if}

<h1>using charts.js</h1>

{#if dashboard.graphs}
	{#each dashboard.graphs as g}
		<Bar
			data={{
				labels: g.data[g.xaxisTitle],
				datasets: [
					{
						label: g.yaxisTitle,
						data: g.data[g.yaxisTitle]
					}
				]
			}}
			{options}
		/>
	{/each}
{/if}

{#if dashboard.graphs}
	{#each dashboard.graphs as g}
		<Pie
			data={{
				labels: g.data[g.xaxisTitle],
				datasets: [
					{
						data: g.data[g.yaxisTitle],
						backgroundColor:COLORS
					}
				]
			}}
			{options}
		/>
	{/each}
{/if}
