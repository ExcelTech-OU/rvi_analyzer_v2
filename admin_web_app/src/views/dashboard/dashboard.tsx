import { Container, Grid } from '@mui/material'
import { SummaryCard } from './summary_card'
import DevicesOtherIcon from '@mui/icons-material/DevicesOther';
import PeopleIcon from '@mui/icons-material/People';
import AccessibilityIcon from '@mui/icons-material/Accessibility';
import { useGetDashboardSummaryQuery } from '../../services/dashboard_service';
import ForumIcon from '@mui/icons-material/Forum';

export default function Dashboard() {
    const { data, error, isLoading } = useGetDashboardSummaryQuery("")
    return (
        isLoading ? <></> : <Container maxWidth={false}>
            <Grid
                container
                spacing={3}
            >
                <Grid
                    item
                    lg={3}
                    sm={6}
                    xl={3}
                    xs={12}
                >
                    <SummaryCard title='DEVICES' icon={<DevicesOtherIcon />} value={data!.numberOfDevices} color='warning.main' path='/devices' />
                </Grid>
                <Grid
                    item
                    xl={3}
                    lg={3}
                    sm={6}
                    xs={12}
                >
                    <SummaryCard title='USERS' icon={<PeopleIcon />} value={data!.numberOfUsers} color='success.light' path='/users' />
                </Grid>
                <Grid
                    item
                    xl={3}
                    lg={3}
                    sm={6}
                    xs={12}
                >
                    <SummaryCard title='SESSIONS' icon={<AccessibilityIcon />} value={data!.numberOfSessions} color='success.main' path='/sessions' />

                </Grid>
                <Grid
                    item
                    xl={3}
                    lg={3}
                    sm={6}
                    xs={12}
                >
                    <SummaryCard title='QUESTIONS' icon={<ForumIcon />} value={data!.numberOfQuestions} color='success.dark' path='/questions' />

                </Grid>

            </Grid>
        </Container>
    )
}
