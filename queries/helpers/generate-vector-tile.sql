WITH tilebounds (geom) AS (SELECT ST_MakeEnvelope($1, $2, $3, $4, 3857))
SELECT ST_AsMVT(q, 'project-centroids', 4096, 'geom')
FROM (
  SELECT
    projectid,
    dcp_projectname,
    dcp_publicstatus_simp,
    lastmilestonedate,
    ST_AsMVTGeom(
      x.$6^,
      tileBounds.geom,
      4096,
      256,
      false
    ) geom
  FROM (
    $5^
  ) x, tilebounds
  WHERE x.$6^ && tilebounds.geom
  ORDER BY CASE WHEN dcp_publicstatus_simp = 'In Public Review' then 1
                WHEN dcp_publicstatus_simp = 'Filed' then 2
                WHEN dcp_publicstatus_simp = 'Completed' then 3
                ELSE 4
           END DESC
) q
