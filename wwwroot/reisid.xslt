<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes"/>

	<!-- Vahelduv värv tabeli ridadele -->
	<xsl:key name="rowcolor" match="reis" use="position() mod 2"/>

	<xsl:template match="/reisid">
		<html>
			<head>
				<style>
					.yellow-bg {background-color: yellow;}
					.high-price {color: red; font-weight: bold;}
					table {border-collapse: collapse; width: 100%;}
					th, td {border: 1px solid black; padding: 5px;}
					tr:nth-child(odd) {background-color: #f0f0f0;}
					tr:nth-child(even) {background-color: #ffffff;}
				</style>
			</head>
			<body>

				<!-- Sorteeri ja filtreeri reisid -->
				<xsl:for-each select="reis[contains(Lennujaam, 'Airport')]">
					<xsl:sort select="number(Kestus)" data-type="number" order="descending"/>

					<!-- Sihtkoht pealkirjana -->
					<h1>
						<xsl:value-of select="@Sihtkoht"/>
					</h1>

					<!-- Täpploetelu komponentidest -->
					<ul>
						<li>
							Lennujaam: <xsl:value-of select="Lennujaam"/>
						</li>
						<li>
							Transport: <xsl:value-of select="Transport"/>
						</li>
						<li>
							Kestus: <xsl:value-of select="Kestus"/> päeva
						</li>
						<!-- Kolmanda taseme element kollasel taustal -->
						<li class="yellow-bg">
							Reisi algus päev: <xsl:value-of select="ReisiAlgusPaev"/>
						</li>
						<!-- Tingimus hinna tõstmiseks -->
						<li>
							Hind:
							<span>
								<xsl:choose>
									<xsl:when test="number(substring(@Hind, 2)) &gt; 70">
										<span class="high-price">
											<xsl:value-of select="@Hind"/>
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@Hind"/>
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</li>
						<!-- Kogumaksumus (siin lihtsalt hind) -->
						<li>
							Kogumaksumus: <xsl:value-of select="@Hind"/>
						</li>
					</ul>
				</xsl:for-each>

				<hr/>

				<!-- Kõik andmed tabelina (vahelduv värviga read) -->
				<table>
					<tr>
						<th>Sihtkoht</th>
						<th>Lennujaam</th>
						<th>Transport</th>
						<th>Kestus (päevad)</th>
						<th>Reisi algus</th>
						<th>Hind</th>
					</tr>
					<xsl:for-each select="reis[contains(Lennujaam, 'Airport')]">
						<xsl:sort select="number(Kestus)" data-type="number" order="descending"/>
						<tr>
							<td>
								<xsl:value-of select="@Sihtkoht"/>
							</td>
							<td>
								<xsl:value-of select="Lennujaam"/>
							</td>
							<td>
								<xsl:value-of select="Transport"/>
							</td>
							<td>
								<xsl:value-of select="Kestus"/>
							</td>
							<td class="yellow-bg">
								<xsl:value-of select="ReisiAlgusPaev"/>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="number(substring(@Hind, 2)) &gt; 70">
										<span class="high-price">
											<xsl:value-of select="@Hind"/>
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@Hind"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
				</table>

			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
