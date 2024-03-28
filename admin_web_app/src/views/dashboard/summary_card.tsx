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
        sx={{
          maxWidth: 1600, backgroundColor: "#FFFFFF", boxShadow: "1px 1px 10px 10px #e8e8e8",
          transition: 'transform 0.3s',
          '&:hover': {
            transform: 'scale(1.1)', // Adjust the scaling factor as desired
          },
        }}
      // onClick={() => navigate(path)}
      >
        <CardContent>
          <Grid
            container
            sx={{ justifyContent: 'space-between' ,height:150 }}
          >
            <Grid item>
              <Typography
                sx={{ mt: 1 }}
                color="grey"
                gutterBottom
                variant="h6"
              >
                {title}
              </Typography>
              <Typography
                sx={{ mt: 2, color: "grey", fontSize: 11 }}
                color="textPrimary"
              >
                Total sessions
              </Typography>
              <Typography
                sx={{ mt: 0.5, fontWeight: "bold", color: "black" }}
                color="textPrimary"
                variant="h4"
              >
                {value}
              </Typography>
            </Grid>
            <Grid item>
              {/* <Avatar
                sx={{
                  backgroundColor: color,
                  height: 35,
                  width: 35
                }}
              >
                {icon}
              </Avatar> */}
            </Grid>
          </Grid>

        </CardContent>
      </Card>
    </Link>
  );
}