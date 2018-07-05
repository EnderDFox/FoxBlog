UPDATE pm.pm_version AS ta,
 pm_version AS tb,
(SELECT
@a:
=sort
FROM
	pm.pm_version
WHERE
	vid = 122
) AS ta1
SET ta
.sort = 3,
 tb.sort = tb.sort + 1
WHERE
	ta.vid = 130
AND tb.vid <> 130
AND tb.sort >= @a
AND tb.sort < 10