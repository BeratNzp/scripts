pagination.php
<?php
for ($i=0; $i < 101; $i++) { 
	$arr[$i] = $i ;
}
$current_page = 1;
$total_items = count($arr);
$items_per_page = 10;
$total_pages = ceil($total_items/$items_per_page);
if(isset($_GET['page'])){
	if(stripslashes($_GET['page'])>0 && stripslashes($_GET['page'])<=$total_pages)
		$current_page = stripslashes($_GET['page']);
	if(stripslashes($_GET['page'])<=0 OR stripslashes($_GET['page'])>$total_pages)
		header("Location: ?page=1");
}else{
	$current_page = 1;
}
echo "Sayfalandırma olmadan içerikler: ";
echo "<br>";
for($i=0; $i<$total_items; $i++){
	if(isset($arr[$i])){
		echo $arr[$i].", ";
	}
}
echo "<hr>";
echo "Toplam içerik sayısı: " . $total_items;
echo "<hr>";
echo "Toplam sayfa sayısı: " . $total_pages;
echo "<hr>";
echo "Şuanki sayfa: " . $current_page;
echo "<hr>";
echo "Sayfalandırmaya göre içerikler: ";
?>
<ul id="items">
	<?php
	for($i=$current_page*$items_per_page-10; $i<$items_per_page*$current_page; $i++){
		if(isset($arr[$i])){
			echo "<li>".$arr[$i]."</li>";
			echo "<br>";
		}
	}
	?>
</ul>
<hr>
Sayfalar:
<ul id="pagination" style="  list-style-type: none;">
	<?php
	for($i=1; $i<$total_pages+1; $i++){
		?>
		<li style="display: block; text-decoration: none; display:inline;">
			<a href="?page=<?php echo $i; ?>">
				<?php echo $i; ?> -
			</a>
		</li>
		<?php
	}
	?>
</ul>
