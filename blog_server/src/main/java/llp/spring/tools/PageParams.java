package llp.spring.tools;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class PageParams {
    private long page = 1L;
    private long rows = 2L;
    private long total;
}
