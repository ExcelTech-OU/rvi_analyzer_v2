import { Avatar, Box, Card, CardContent, Grid, Typography } from '@mui/material';
import { ReactNode } from 'react';
import { Link, useNavigate } from 'react-router-dom';

type SummaryCardData = {
  title: string,
  icon: ReactNode,
  value: string,
  path: string,
  color: string
}

export function SummaryCard({ title, value, icon, path, color }: SummaryCardData) {
  const navigate = useNavigate();

  return (
    <Link to={path} style={{ textDecoration: 'none' }}>
      <Card
        sx={{ height: '100%' }}
      // onClick={() => navigate(path)}
      >
        <CardContent>
          <Grid
            container
            spacing={3}
            sx={{ justifyContent: 'space-between' }}
          >
            <Grid item>
              <Typography
                color="textSecondary"
                gutterBottom
                variant="overline"
              >
                {title}
              </Typography>
              <Typography
                color="textPrimary"
                variant="h4"
              >
                {value}
              </Typography>
            </Grid>
            <Grid item>
              <Avatar
                sx={{
                  backgroundColor: color,
                  height: 56,
                  width: 56
                }}
              >
                {icon}
              </Avatar>
            </Grid>
          </Grid>

        </CardContent>
      </Card>
    </Link>
  );
}